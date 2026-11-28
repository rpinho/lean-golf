from pathlib import Path
import sys

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from test_ci import FakeGitHub, HEAD, Rejected, SLUG, submission


@pytest.mark.parametrize("filename", ["Player.LEAN", "Player.lean.txt", "Pláyer.lean"])
def test_submission_uses_a_login_and_exact_lean_suffix(filename):
    api = FakeGitHub()
    api.files[0]["filename"] = f"submissions/{SLUG}/{filename}"
    with pytest.raises(Rejected, match="your GitHub login"):
        submission(api, 11, HEAD, "main")
    assert not any(path.startswith("git/blobs/") for _, path in api.requests)
