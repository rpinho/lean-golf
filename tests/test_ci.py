import base64
from copy import deepcopy
from hashlib import sha1, sha256
import json
from pathlib import Path
import sys

import pytest


sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))
import ci  # noqa: E402
from ci import GitHub, Rejected, check_result, publish_record, submission  # noqa: E402
from test_records_site import FIXTURE, RESULT, SLUG, TIMESTAMP  # noqa: E402


HEAD = "a" * 40
BASE = "b" * 40
MERGED = "c" * 40
FORK = "player/lean-golf"
REPO = "owner/lean-golf"
PATH = f"submissions/{SLUG}/Player.lean"
PROOF = b"theorem fixture : True := by trivial\n"


def oid(content):
    return sha1(f"blob {len(content)}\0".encode() + content).hexdigest()


class FakeGitHub(GitHub):
    def __init__(self):
        super().__init__(REPO)
        self.pr = dict(number=11, state="open", merged=False, changed_files=1,
                       user=dict(login="player", type="User"),
                       head=dict(sha=HEAD, repo=dict(id=500, full_name=FORK)),
                       base=dict(ref="main", repo=dict(full_name=REPO)))
        self.files = [dict(filename=PATH, status="added", sha=oid(PROOF))]
        self.entry = dict(path="Player.lean", mode="100644", type="blob", size=len(PROOF),
                          sha=oid(PROOF))
        self.blobs = {oid(PROOF): PROOF}
        self.requests = []
        self.writes = []
        self.record_commits = []
        self.conflicts = 0
        self.tree = {}
        for path, (mode, sha) in ci.verifier_objects(Path(ci.__file__).resolve().parents[1]).items():
            self.tree[path] = dict(mode=mode, sha=sha)
        for path in (FIXTURE / "theorems" / SLUG).iterdir():
            blob = path.read_bytes()
            self.blobs[oid(blob)] = blob
            self.tree[f"theorems/{SLUG}/{path.name}"] = dict(mode="100644", type="blob",
                                                            sha=oid(blob))

    def get(self, suffix, repo=None):
        self.requests.append((repo or self.repo, suffix))
        assert repo in (None, self.repo)
        if suffix == "pulls/11":
            return deepcopy(self.pr)
        if suffix.startswith("pulls?"):
            return [deepcopy(self.pr)]
        if suffix == "pulls/11/files?per_page=2":
            return deepcopy(self.files)
        if suffix.startswith("git/blobs/"):
            blob = self.blobs[suffix.split("/")[-1]]
            return dict(encoding="base64", size=len(blob), content=base64.b64encode(blob).decode())
        if suffix == f"git/commits/{HEAD}":
            return {"tree": {"sha": "root"}}
        nodes = {
            "git/trees/root": dict(path="submissions", mode="040000", sha="submissions"),
            "git/trees/submissions": dict(path=SLUG, mode="040000", sha="slug"),
            "git/trees/slug": self.entry,
        }
        return {"truncated": False, "tree": [deepcopy(nodes[suffix])]}

    def snapshot(self, branch):
        return MERGED if self.pr["merged"] else BASE, deepcopy(self.tree)

    def tree_at(self, head):
        assert head == MERGED and self.pr["merged"]
        return self.tree

    def request(self, path, *, method, data):
        self.writes.append((path, method, data))
        if method == "PUT":
            assert data == dict(sha=HEAD, merge_method="squash")
            self.pr.update(state="closed", merged=True, merged_at=TIMESTAMP, merge_commit_sha=MERGED)
            self.tree[PATH] = self.entry
            return {"merged": True}
        return {}

    def commit_records(self, branch, base, root, paths, number):
        self.record_commits.append((branch, base, number))
        if self.conflicts:
            self.conflicts -= 1
            return None
        for path in paths:
            content = path.read_bytes()
            self.blobs[oid(content)] = content
            self.tree[path.relative_to(root).as_posix()] = dict(mode="100644", type="blob",
                                                               sha=oid(content))
        return "d" * 40


def receipt(api):
    item = submission(api, 11, HEAD, "main")
    policy = (FIXTURE / "theorems" / SLUG / "theorem.json").read_bytes()
    return dict(**item.receipt(), result=RESULT, raw_statement_sha256=RESULT["statement_hash"],
                policy_sha256=sha256(policy).hexdigest(),
                verifier_objects=ci.verifier_objects(Path(ci.__file__).resolve().parents[1]))


@pytest.mark.parametrize("change", ["policy", "checker"])
def test_publication_requires_the_verified_rules(change):
    api = FakeGitHub()
    trusted = receipt(api)
    if change == "policy":
        entry = api.tree[f"theorems/{SLUG}/theorem.json"]
        policy = json.loads(api.blobs[entry["sha"]])
        policy["forbidden"] = ["Nat.zero_le"]
        content = json.dumps(policy).encode()
        entry["sha"] = oid(content)
        api.blobs[oid(content)] = content
    else:
        api.tree["LeanGolf"]["sha"] = "f" * 40
    with pytest.raises(Rejected, match=f"{change} changed or needs fresh verification"):
        publish_record(api, "main", trusted)
    assert not api.writes and not api.record_commits


def test_fork_run_and_single_immutable_blob():
    api = FakeGitHub()
    run = dict(event="pull_request", conclusion="success", head_sha=HEAD, head_branch="feature",
               pull_requests=[], head_repository=dict(id=500, owner=dict(login="player")))
    assert api.find_pull(run, "main")["number"] == 11
    data = receipt(api)
    assert data["login"] == "player"
    assert data["proof_sha256"] == sha256(PROOF).hexdigest()
    requests = [pair for pair in api.requests if pair[1].startswith("git/blobs/")]
    assert requests == [(REPO, f"git/blobs/{oid(PROOF)}")]


@pytest.mark.parametrize("alter", ["head", "second-file", "login", "symlink", "too-large",
                                    "wrong-blob"])
def test_submission_rejections_do_not_download_proof(alter):
    api = FakeGitHub()
    if alter == "head":
        api.pr["head"]["sha"] = "e" * 40
    if alter == "second-file":
        api.files.append(api.files[0])
    if alter == "login":
        api.files[0]["filename"] = f"submissions/{SLUG}/another.lean"
    if alter == "symlink":
        api.entry["mode"] = "120000"
    if alter == "too-large":
        api.entry["size"] = 65537
    if alter == "wrong-blob":
        api.files[0]["sha"] = "e" * 40
    with pytest.raises(Rejected):
        submission(api, 11, HEAD, "main")
    assert not any(path.startswith("git/blobs/") for _, path in api.requests)


def test_squash_is_pinned_and_record_commit_retries_without_merging_again():
    api = FakeGitHub()
    trusted = receipt(api)
    api.conflicts = 1
    assert publish_record(api, "main", trusted)
    assert len(api.writes) == 1
    assert len(api.record_commits) == 2
    assert all(item == ("main", MERGED, 11) for item in api.record_commits)
    assert api.blobs[api.tree[f"theorems/{SLUG}/Record.lean"]["sha"]] == PROOF
    assert publish_record(api, "main", trusted)
    assert len(api.writes) == 1
    assert len(api.record_commits) == 2


def test_open_theorem_verifies_and_publishes_first_record(tmp_path, monkeypatch):
    api = FakeGitHub()
    for name in ("record.json", "Record.lean"):
        api.tree.pop(f"theorems/{SLUG}/{name}")
    folder = tmp_path / "theorems" / SLUG
    folder.mkdir(parents=True)
    for name in ("Statement.lean", "theorem.json"):
        (folder / name).write_bytes((FIXTURE / "theorems" / SLUG / name).read_bytes())
    summary = tmp_path / "summary.md"
    monkeypatch.setenv("GITHUB_STEP_SUMMARY", str(summary))
    monkeypatch.setattr(ci, "run_checker", lambda root, item, expected: RESULT)
    event = {"repository": {"default_branch": "main"}, "pull_request": api.pr}
    result_path = tmp_path / "result.json"
    assert ci.verify(api, event, tmp_path, result_path, trusted=False) == 0
    assert "first valid proof sets the record" in summary.read_text()
    assert json.loads(result_path.read_text()) == RESULT

    trusted = receipt(api)
    assert publish_record(api, "main", trusted)
    assert [method for _, method, _ in api.writes] == ["PUT"]
    assert api.blobs[api.tree[f"theorems/{SLUG}/Record.lean"]["sha"]] == PROOF
    history = json.loads(api.blobs[api.tree["data/history.jsonl"]["sha"]])
    assert history["previous"] is None and history["score"] == RESULT["score"]
    assert publish_record(api, "main", trusted)
    assert len(api.record_commits) == 1


def test_tie_closes_with_its_score_without_record_writes():
    api = FakeGitHub()
    trusted = dict(receipt(api), result=dict(RESULT, score=26))
    assert not publish_record(api, "main", trusted)
    assert [method for _, method, _ in api.writes] == ["POST", "PATCH"]
    assert "**26**" in api.writes[0][2]["body"]
    assert not api.record_commits


def test_squash_confirmation_uses_bytes_before_publishing():
    api = FakeGitHub()
    trusted = receipt(api)
    api.tree_at = lambda head: {PATH: dict(api.entry, sha=oid(b"unexpected"))}
    api.blobs[oid(b"unexpected")] = b"unexpected"
    with pytest.raises(RuntimeError, match="does not contain the verified proof bytes"):
        publish_record(api, "main", trusted)
    assert not api.record_commits


def test_record_retry_checks_current_proof_bytes():
    api = FakeGitHub()
    trusted = receipt(api)
    def concurrent_update(branch, base, root, paths, number):
        api.record_commits.append((branch, base, number))
        api.tree.pop(PATH)
        return None

    api.commit_records = concurrent_update
    with pytest.raises(Rejected, match="submitted file changed after the verified merge"):
        publish_record(api, "main", trusted)
    assert len(api.record_commits) == 1


def test_changed_head_blocks_publication_before_any_write():
    api = FakeGitHub()
    trusted = receipt(api)
    api.pr["head"]["sha"] = "f" * 40
    with pytest.raises(Rejected, match="head has changed"):
        publish_record(api, "main", trusted)
    assert not api.writes and not api.record_commits


def test_verifier_rejects_results_that_disagree_with_controls():
    assert check_result(RESULT, 0, RESULT["statement_hash"]) == RESULT
    with pytest.raises(RuntimeError):
        check_result(RESULT, 1, RESULT["statement_hash"])
    with pytest.raises(RuntimeError):
        check_result(RESULT, 0, "f" * 64)
    with pytest.raises(RuntimeError):
        check_result(dict(RESULT, axioms=["sorryAx"]), 0, RESULT["statement_hash"])


@pytest.mark.parametrize("fields", [
    {"score": 0}, {"score": ci.MAX_BYTES + 1}, {"reason": "compilation failed"},
])
def test_valid_result_has_consistent_score_and_diagnostics(fields):
    with pytest.raises(RuntimeError, match="checker result disagrees"):
        check_result(dict(RESULT, **fields), 0, RESULT["statement_hash"])


def test_rejection_requires_a_reason():
    with pytest.raises(RuntimeError, match="did not exit normally"):
        check_result(ci.invalid(""), 1, RESULT["statement_hash"])
