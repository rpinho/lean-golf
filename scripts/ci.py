#!/usr/bin/env python3
"""Check a pull request's immutable submission and publish verified records."""
import argparse
import base64
from dataclasses import dataclass
from hashlib import sha1, sha256
from html import escape
import json
import os
from pathlib import Path
import re
import subprocess
import tarfile
import tempfile
from time import monotonic
from urllib.error import HTTPError
from urllib.parse import quote, urlencode
from urllib.request import Request, urlopen
from uuid import uuid4

from records import DIGEST, LOGIN, SLUG, apply, read_json, write_json


MAX_BYTES = 64 * 1024
OID = re.compile(r"[0-9a-f]{40}")
REPOSITORY = re.compile(r"[A-Za-z0-9-]+/[A-Za-z0-9_.-]+")
STATEMENT_HASH = "statement_hash"


class Rejected(ValueError):
    pass


class ApiError(RuntimeError):
    def __init__(self, status, message):
        super().__init__(f"GitHub API ({status}): {message}")
        self.status = status


class GitHub:
    def __init__(self, repo, token=None):
        if not REPOSITORY.fullmatch(repo):
            raise ValueError("Invalid repository")
        self.repo = repo
        self.token = token

    def request(self, path, *, method="GET", data=None):
        headers = {"Accept": "application/vnd.github+json",
                   "X-GitHub-Api-Version": "2022-11-28"}
        if self.token:
            headers["Authorization"] = f"Bearer {self.token}"
        body = None
        if data is not None:
            headers["Content-Type"] = "application/json"
            body = json.dumps(data).encode()
        request = Request("https://api.github.com" + path, data=body, headers=headers, method=method)
        try:
            with urlopen(request, timeout=12) as response:
                return json.load(response)
        except HTTPError as error:
            raise ApiError(error.code, json.load(error).get("message", error.reason)) from error

    def get(self, suffix, repo=None):
        return self.request(f"/repos/{repo or self.repo}/{suffix}")

    def pull(self, number):
        return self.get(f"pulls/{number}")

    def find_pull(self, run, branch):
        if run["event"] != "pull_request" or run["conclusion"] != "success":
            raise Rejected("The completed run has no successful pull request check.")
        repo = run.get("head_repository") or {}
        owner = (repo.get("owner") or {}).get("login", "")
        if not LOGIN.fullmatch(owner) or not OID.fullmatch(run["head_sha"]):
            raise Rejected("The completed run has no valid head repository or commit.")
        for page in range(1, 6):
            query = urlencode(dict(state="open", head=f"{owner}:{run['head_branch']}",
                                   base=branch, per_page=100, page=page))
            pulls = self.get(f"pulls?{query}")
            matches = [pull for pull in pulls
                       if pull["head"]["sha"] == run["head_sha"]
                       and (pull["head"].get("repo") or {}).get("id") == repo["id"]]
            if len(matches) == 1:
                return matches[0]
            if matches or len(pulls) < 100:
                break
        raise Rejected("No unique open pull request matches the completed run's exact head.")

    def blob(self, repo, oid, limit=None):
        if not REPOSITORY.fullmatch(repo) or not OID.fullmatch(oid):
            raise Rejected("Invalid repository or blob ID.")
        data = self.get(f"git/blobs/{oid}", repo)
        if data["encoding"] != "base64" or (limit is not None and data["size"] > limit):
            raise Rejected("The submission exceeds 64 KB or is not a readable blob.")
        content = base64.b64decode("".join(data["content"].split()), validate=True)
        git_oid = sha1(f"blob {len(content)}\0".encode() + content).hexdigest()
        if git_oid != oid or len(content) != data["size"]:
            raise Rejected("The downloaded bytes do not match GitHub's blob ID.")
        return content

    def snapshot(self, branch):
        ref = self.get("git/ref/heads/" + quote(branch, safe=""))
        head = ref["object"]["sha"]
        return head, self.tree_at(head)

    def tree_at(self, head):
        tree = self.get(f"git/commits/{head}")["tree"]["sha"]
        snapshot = self.get(f"git/trees/{tree}?recursive=1")
        if snapshot["truncated"]:
            raise RuntimeError("The default branch tree response was truncated.")
        return {entry["path"]: entry for entry in snapshot["tree"]}

    def commit_records(self, branch, base, root, paths, number):
        query = """
          mutation($input: CreateCommitOnBranchInput!) {
            createCommitOnBranch(input: $input) { commit { oid } }
          }
        """
        additions = [dict(path=path.relative_to(root).as_posix(),
                          contents=base64.b64encode(path.read_bytes()).decode("ascii"))
                     for path in paths]
        inputs = dict(branch=dict(repositoryNameWithOwner=self.repo, branchName=branch),
                      expectedHeadOid=base, message=dict(headline=f"Record proof from #{number}"),
                      fileChanges=dict(additions=additions))
        response = self.request("/graphql", method="POST",
                                data=dict(query=query, variables=dict(input=inputs)))
        if response.get("errors"):
            errors = response["errors"]
            if all(error.get("type") == "STALE_DATA" for error in errors):
                return None
            raise RuntimeError(f"Record commit failed: {errors[0]['message']}")
        return response["data"]["createCommitOnBranch"]["commit"]["oid"]


@dataclass(frozen=True)
class Submission:
    number: int
    head: str
    repo_id: int
    slug: str
    login: str
    path: str
    content: bytes

    def receipt(self):
        return dict(pr=self.number, head=self.head, repo_id=self.repo_id, slug=self.slug,
                    login=self.login, path=self.path, proof_sha256=sha256(self.content).hexdigest())


def submission(api, number, expected_head, branch, *, allow_merged=False):
    pull = api.pull(number)
    head = pull["head"]
    repo = head.get("repo") or {}
    source = repo.get("full_name", "")
    login = pull["user"]["login"]
    if not OID.fullmatch(expected_head) or head["sha"] != expected_head:
        raise Rejected("The pull request head has changed.")
    if pull["base"]["ref"] != branch or pull["base"]["repo"]["full_name"].lower() != api.repo.lower():
        raise Rejected("The pull request must target the default branch.")
    if pull["state"] != "open" and not (allow_merged and pull["merged"]):
        raise Rejected("The pull request is not open.")
    if (pull["changed_files"] != 1 or not REPOSITORY.fullmatch(source)
            or pull["user"]["type"] != "User" or not LOGIN.fullmatch(login)):
        raise Rejected("A submission must change one file from a user account.")
    files = api.get(f"pulls/{number}/files?per_page=2")
    if len(files) != 1 or files[0]["status"] not in {"added", "modified"}:
        raise Rejected("Add or edit exactly one submission file.")
    file = files[0]
    parts = file["filename"].split("/")
    if (len(parts) != 3 or parts[0] != "submissions" or not SLUG.fullmatch(parts[1])
            or parts[2].lower() != f"{login.lower()}.lean"):
        raise Rejected("Use submissions/<slug>/<your GitHub login>.lean.")
    # Walk only the three named entries in the immutable tree and fetch only this blob.
    tree = api.get(f"git/commits/{expected_head}", source)["tree"]["sha"]
    for part in parts[:-1]:
        tree = entry(api, source, tree, part, "040000")["sha"]
    proof = entry(api, source, tree, parts[-1], "100644")
    if proof["size"] > MAX_BYTES:
        raise Rejected("The submission exceeds 64 KB.")
    if proof["sha"] != file["sha"]:
        raise Rejected("The changed-file list disagrees with the recorded commit.")
    content = api.blob(source, proof["sha"], limit=MAX_BYTES)
    if api.pull(number)["head"]["sha"] != expected_head:
        raise Rejected("The pull request head changed during verification.")
    return Submission(number, expected_head, repo["id"], parts[1], login.lower(), file["filename"],
                      content)


def entry(api, repo, tree, name, mode):
    response = api.get(f"git/trees/{tree}", repo)
    for item in response["tree"]:
        if item["path"] == name and item["mode"] == mode and not response["truncated"]:
            return item
    raise Rejected("The submission must be a regular, non-executable file in the recorded commit.")


def reject_case_alias(paths, path):
    if any(other != path and other.lower() == path.lower() for other in paths):
        raise Rejected("Use the spelling of your existing submission path.")


def check_result(result, code, statement_hash):
    if (not isinstance(result, dict)
            or set(result) != {"valid", "score", "statement_hash", "axioms", "reason"}
            or type(result["valid"]) is not bool or not isinstance(result["reason"], str)
            or not isinstance(result["axioms"], list)
            or not all(isinstance(axiom, str) for axiom in result["axioms"])
            or not isinstance(result[STATEMENT_HASH], str)):
        raise RuntimeError("The checker did not return the expected result schema.")
    if result["valid"]:
        if (code != 0 or type(result["score"]) is not int or result["score"] < 0
                or result[STATEMENT_HASH] != statement_hash
                or not set(result["axioms"]) <= {"propext", "Classical.choice", "Quot.sound"}):
            raise RuntimeError("The checker result disagrees with its exit status or theorem metadata.")
    elif code != 1 or result["score"] is not None:
        raise RuntimeError("The checker did not exit normally.")
    return result


def run_checker(root, item, statement_hash):
    image = subprocess.check_output(["bash", "scripts/image-ref.sh"], cwd=root, text=True).strip()
    cached = subprocess.run(["docker", "image", "inspect", image], stdout=subprocess.DEVNULL,
                            stderr=subprocess.DEVNULL, timeout=5)
    if cached.returncode:
        # A cold pull of the Mathlib image takes about 90 s; it has its own budget, outside the checker's.
        subprocess.run(["docker", "pull", "-q", image], check=True, timeout=240)
    deadline = monotonic() + 145
    name = f"lean-golf-{uuid4().hex}"
    with tempfile.TemporaryDirectory() as work:
        temp = Path(work)
        source = temp / "source"
        source.mkdir()
        archive = temp / "source.tar"
        subprocess.run(["git", "archive", "--output", archive, "HEAD"], cwd=root, check=True)
        with tarfile.open(archive) as tar:
            tar.extractall(source, filter="data")
        proof = temp / "Submission.lean"
        proof.write_bytes(item.content)

        command = [
            "docker", "run", "--rm", "--name", name, "--pull", "never", "--network", "none",
            "--read-only", "--cap-drop", "ALL", "--security-opt", "no-new-privileges",
            "--memory", "10g", "--cpus", "2", "--pids-limit", "128", "--log-driver", "none",
            "--tmpfs", "/work:rw,exec,nosuid,nodev,size=1g,uid=10001,gid=10001,mode=0700",
            "--mount", f"type=bind,src={source},dst=/source,readonly",
            "--mount", f"type=bind,src={proof},dst=/Submission.lean,readonly",
            image, "timeout", "--kill-after=3s", "140s",
            "sh", "/source/scripts/in-container.sh", item.slug,
        ]
        with tempfile.TemporaryFile() as output:
            try:
                # Limit stdout on disk and suppress untrusted subprocess output in Actions logs.
                bounded = ["sh", "-c", 'ulimit -f 256; exec "$@"', "golfcheck", *command]
                run = subprocess.run(bounded, stdout=output, stderr=subprocess.DEVNULL,
                                     timeout=max(1, deadline - monotonic()))
            finally:
                subprocess.run(["docker", "kill", name], stdout=subprocess.DEVNULL,
                               stderr=subprocess.DEVNULL, timeout=5)
            output.seek(0)
            lines = output.read(128 * 1024).splitlines()
            if len(lines) != 1:
                raise RuntimeError("The checker did not return exactly one JSON line.")
            return check_result(json.loads(lines[0]), run.returncode, statement_hash)


def theorem(root, slug):
    folder = root / "theorems" / slug
    if not (folder / "Statement.lean").is_file() or not (folder / "theorem.json").is_file():
        raise Rejected("The theorem has no statement packet on the default branch.")
    meta = read_json(folder / "theorem.json")
    if meta["slug"] != slug or not DIGEST.fullmatch(meta[STATEMENT_HASH]):
        raise RuntimeError("The default branch has invalid theorem metadata.")
    digest = sha256((folder / "Statement.lean").read_bytes()).hexdigest()
    return meta[STATEMENT_HASH], digest


def summary(result, old_score=None):
    if result["valid"]:
        if old_score is None:
            outcome = "This theorem is open. The first valid proof sets the record."
        elif result["score"] >= old_score:
            outcome = f"The current record is {old_score} characters."
        else:
            outcome = f"This improves the current record of {old_score} characters."
        body = f"**{result['score']} characters.** {outcome}"
    else:
        reason = "".join(c for c in result["reason"][:1000] if c.isprintable() or c == "\n")
        body = f"<pre>{escape(reason)}</pre>"
    with open(os.environ["GITHUB_STEP_SUMMARY"], "a", encoding="utf-8") as out:
        out.write(f"## Lean Golf check\n\n{body}\n")


def invalid(reason):
    return dict(valid=False, score=None, statement_hash="", axioms=[], reason=reason)


def verify(api, event, root, result_path, *, trusted):
    branch = event["repository"]["default_branch"]
    try:
        if trusted:
            origin = api.find_pull(event["workflow_run"], branch)
        else:
            origin = event["pull_request"]
        item = submission(api, origin["number"], origin["head"]["sha"], branch)
        if item.repo_id != origin["head"]["repo"]["id"]:
            raise Rejected("The pull request's source repository changed.")
        folder = root / "submissions" / item.slug
        reject_case_alias((p.relative_to(root).as_posix() for p in folder.glob("*")), item.path)
        expected_hash, raw_hash = theorem(root, item.slug)
        result = run_checker(root, item, expected_hash)
        record_path = root / "theorems" / item.slug / "record.json"
        old_score = read_json(record_path)["score"] if record_path.is_file() else None
    except Rejected as error:
        result, old_score = invalid(str(error)), None
    except (OSError, ApiError, RuntimeError, ValueError, subprocess.SubprocessError) as error:
        result = invalid("The verifier could not complete. See the workflow logs.")
        write_json(result_path, result)
        summary(result)
        raise SystemExit(str(error)) from None

    write_json(result_path, result)
    summary(result, old_score)
    if trusted and result["valid"]:
        receipt = dict(**item.receipt(), result=result, raw_statement_sha256=raw_hash)
        # Exclude checker-provided prose from the handoff to the writing job.
        receipt["result"] = dict(result, reason="")
        with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as out:
            out.write("receipt=" + json.dumps(receipt, separators=(",", ":")) + "\n")
    return 0 if trusted or result["valid"] else 1


def read_blob(api, tree, path, *, optional=False, checkout=None):
    if optional and path not in tree:
        return None
    entry = tree.get(path)
    if entry is None or entry["mode"] != "100644" or entry["type"] != "blob":
        raise RuntimeError(f"Expected a regular default-branch file at {path}.")
    if checkout is not None:
        local = checkout / path
        if local.is_file() and not local.is_symlink():
            content = local.read_bytes()
            oid = sha1(f"blob {len(content)}\0".encode() + content).hexdigest()
            if oid == entry["sha"]:
                return content
    return api.blob(api.repo, entry["sha"])


def latest_record(api, tree, item, receipt):
    folder = f"theorems/{item.slug}"
    meta = json.loads(read_blob(api, tree, f"{folder}/theorem.json"))
    statement = read_blob(api, tree, f"{folder}/Statement.lean")
    expected = receipt["result"][STATEMENT_HASH]
    if (meta["slug"] != item.slug or meta[STATEMENT_HASH] != expected
            or sha256(statement).hexdigest() != receipt["raw_statement_sha256"]):
        raise Rejected("The theorem statement changed after verification.")
    record = read_blob(api, tree, f"{folder}/record.json", optional=True)
    return json.loads(record) if record is not None else None


def record_paths(api, tree, root, item, receipt, utc):
    paths = [name for name in tree if len(name.split("/")) == 3
             and name.split("/")[0] == "theorems" and name.endswith("/record.json")
             and SLUG.fullmatch(name.split("/")[1])]
    paths.append(f"theorems/{item.slug}/theorem.json")
    # Most rows already match the verified default-branch checkout. Fetch only
    # changed rows on retries, rather than issuing one request per record.
    checkout = Path.cwd()
    for name in paths + ["data/history.jsonl"]:
        content = read_blob(api, tree, name, optional=(name == "data/history.jsonl"), checkout=checkout)
        if content is not None:
            path = root / name
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_bytes(content)
    return apply(root, item.slug, item.login, item.number, utc, item.content, receipt["result"])


def publish_record(api, branch, receipt):
    result = receipt["result"]
    expected = result[STATEMENT_HASH]
    if not DIGEST.fullmatch(expected):
        raise Rejected("The trusted verifier did not provide a statement hash.")
    check_result(result, 0, expected)
    if result["valid"] is not True:
        raise Rejected("The trusted verifier did not accept the proof.")
    head = receipt["head"]
    number = receipt["pr"]
    if type(number) is not int or number < 1:
        raise Rejected("Invalid pull request number in the verifier receipt.")
    item = submission(api, number, head, branch, allow_merged=True)
    if any(receipt[key] != value for key, value in item.receipt().items()):
        raise Rejected("The PR no longer matches the trusted verification receipt.")

    _, tree = api.snapshot(branch)
    reject_case_alias(tree, item.path)
    previous = latest_record(api, tree, item, receipt)
    score = result["score"]
    pull = api.pull(number)
    if pull["head"]["sha"] != head or pull["base"]["ref"] != branch or pull["changed_files"] != 1:
        raise Rejected("The pull request changed before publication.")
    if pull["state"] == "open":
        if previous is not None and score >= previous["score"]:
            body = (f"Thanks for golfing this proof! Your verified score is **{score}** characters. "
                    f"The record is **{previous['score']}**, and a new record needs a lower score. "
                    f"Checked commit `{head[:12]}`.")
            api.request(f"/repos/{api.repo}/issues/{number}/comments",
                        method="POST", data={"body": body})
            if api.pull(number)["head"]["sha"] != head:
                raise Rejected("The pull request changed before it could be closed.")
            api.request(f"/repos/{api.repo}/pulls/{number}", method="PATCH", data={"state": "closed"})
            return False
        merged = api.request(f"/repos/{api.repo}/pulls/{number}/merge", method="PUT",
                             data=dict(sha=head, merge_method="squash"))
        if not merged["merged"]:
            raise RuntimeError(f"Squash merge failed: {merged['message']}")
        pull = api.pull(number)
    if not pull["merged"] or not pull["merged_at"] or pull["head"]["sha"] != head:
        raise RuntimeError("GitHub did not confirm a merge of the verified pull request head.")
    merged_tree = api.tree_at(pull["merge_commit_sha"])
    if read_blob(api, merged_tree, item.path) != item.content:
        raise RuntimeError("The squash merge does not contain the verified proof bytes.")

    for _ in range(3):
        base, tree = api.snapshot(branch)
        previous = latest_record(api, tree, item, receipt)
        if previous is not None:
            if previous["pr"] == number and previous["score"] == score:
                return True
            if score >= previous["score"]:
                return False
        with tempfile.TemporaryDirectory() as work:
            root = Path(work)
            paths = record_paths(api, tree, root, item, receipt, pull["merged_at"])
            if paths and api.commit_records(branch, base, root, paths, number):
                return True
    raise RuntimeError("The default branch changed repeatedly. Rerun the trusted publishing job.")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("mode", choices=["check", "verify", "publish"])
    args = parser.parse_args()
    event = read_json(Path(os.environ["GITHUB_EVENT_PATH"]))
    # check and verify read with the job's read-only token: unauthenticated API calls share a 60/hour limit per
    # runner IP and failed the first real check (11-27). The untrusted proof never sees it (the container gets no env).
    api = GitHub(os.environ["GITHUB_REPOSITORY"],
                 os.environ["GOLF_WRITE_TOKEN"] if args.mode == "publish" else os.environ.get("GOLF_READ_TOKEN") or None)
    if args.mode == "publish":
        try:
            changed = publish_record(api, event["repository"]["default_branch"],
                                     json.loads(os.environ["GOLF_RECEIPT"]))
        except Rejected as error:
            raise SystemExit(str(error)) from None
        with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as out:
            out.write(f"published={str(changed).lower()}\n")
    else:
        raise SystemExit(verify(api, event, Path.cwd(), Path("result.json"),
                                trusted=args.mode == "verify"))


if __name__ == "__main__":
    main()
