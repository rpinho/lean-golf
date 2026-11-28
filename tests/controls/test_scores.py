from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "scripts"))
from check_source import score_v1, strip_comments


def test_unicode_whitespace_and_nested_comments():
    proof = "by\t/- α /- nested := -/ \u200b -/\n exact ⟨⟩ -- :=\n"
    assert score_v1(strip_comments(proof)) == len("byexact⟨⟩")


def test_format_character_outside_comment_counts():
    assert score_v1("a\u200bb") == 3
    assert score_v1("a\u2003b") == 2
