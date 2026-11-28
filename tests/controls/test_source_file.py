from pathlib import Path
import sys

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "scripts"))
from check_source import Rejected, read_source


def test_read_source_requires_regular_file(tmp_path):
    proof = tmp_path / "proof.lean"
    proof.write_text("theorem example_proof : True := True.intro\n")
    assert read_source(proof) == (proof.read_bytes(), proof.read_text())
    link = tmp_path / "linked.lean"
    link.symlink_to(proof)
    with pytest.raises(Rejected, match="submission must be a regular file, not a symbolic link"):
        read_source(link)
