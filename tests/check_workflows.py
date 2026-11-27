#!/usr/bin/env python3
"""Check workflow trust boundaries without running a workflow or using the network."""
from pathlib import Path
import re
import textwrap


ROOT = Path(__file__).resolve().parents[1]
WORKFLOWS = ROOT / ".github" / "workflows"


def field(source, name):
    match = re.search(rf"^{re.escape(name)}:[ \t]*(.*)$", source, re.MULTILINE)
    assert match, f"Missing {name}"
    if match[1]:
        return match[1]
    child = re.match(r"\n((?:[ \t]+[^\n]*\n|\n)+)", source[match.end():] + "\n")
    return textwrap.dedent(child[1]).strip() if child else ""


def check():
    check_workflow = (WORKFLOWS / "check.yml").read_text()
    merge_workflow = (WORKFLOWS / "merge.yml").read_text()
    assert field(check_workflow, "on") == "pull_request:"
    assert field(check_workflow, "permissions") == "contents: read"
    assert not re.search(r"\bsecrets\s*(?:\.|\[|:)", check_workflow, re.IGNORECASE)

    check_job = field(field(check_workflow, "jobs"), "check")
    assert not re.search(r"^(?:permissions|environment|container):", check_job, re.MULTILINE)
    assert field(check_job, "timeout-minutes") == "12"
    assert "python3 scripts/ci.py check" in check_job
    assert "path: result.json" in check_job

    event = field(merge_workflow, "on")
    assert field(event, "workflow_run") == "workflows: [Check submission]\ntypes: [completed]"
    assert field(merge_workflow, "permissions") == "{}"
    jobs = field(merge_workflow, "jobs")
    verify, merge = (field(jobs, name) for name in ("verify", "merge"))
    assert field(verify, "permissions") == "contents: read"
    assert not re.search(r"\bsecrets\s*(?:\.|\[|:)", verify, re.IGNORECASE)
    assert "python3 scripts/ci.py verify" in verify
    assert "python3 scripts/ci.py publish" in merge
    assert field(merge, "needs") == "verify"
    assert field(merge, "permissions") == "contents: write\npull-requests: write"
    assert "download-artifact" not in merge_workflow

    expected = ["${{ github.event.repository.default_branch }}"] * 2
    assert re.findall(r"^\s*ref: (.*)$", merge_workflow, re.MULTILINE) == expected
    assert len(re.findall(r"uses: actions/checkout@", merge_workflow)) == len(expected)
    for job in (verify, merge):
        assert "persist-credentials: false" in job
        assert not re.search(r"\bgit\s+(?:checkout|fetch|switch|clone)\b", job)

    forbidden_trigger = "pull_request" + "_target"
    for workflow in WORKFLOWS.glob("*.y*ml"):
        assert forbidden_trigger not in workflow.read_text(), workflow.name

    ci = (ROOT / "scripts" / "ci.py").read_text()
    assert '"--network", "none"' in ci
    assert "merge_method=\"squash\"" in ci
    assert "expectedHeadOid=base" in ci


def test_workflow_boundaries():
    check()


if __name__ == "__main__":
    check()
    print("Workflow trust boundaries passed.")
