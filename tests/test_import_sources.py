from pathlib import Path
import sys


sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))
from import_sources import SOURCES, extract  # noqa: E402


def test_importer_skips_missing_answer_and_copies_plain_statement():
    source = next(source for source in SOURCES if source.key == "putnambench")
    text = """import Mathlib
open Nat

/-
theorem fake : False := by sorry
/- nested comment -/
-/
abbrev putnam_2000_a1_solution : Nat := sorry

theorem putnam_2000_a1 : putnam_2000_a1_solution = 0 := by sorry

theorem putnam_2000_a2 (x : Nat) :
  (let y := x; y) = x := by sorry
"""
    path = Path("lean4/src/putnam_2000_a2.lean")
    extracted = dict(extract(source, path, text))
    assert set(extracted) == {"putnam_2000_a1", "putnam_2000_a2"}
    assert extracted["putnam_2000_a1"] == "answer placeholder"
    meta, statement = extracted["putnam_2000_a2"]
    assert meta["difficulty"] == "2000 A2"
    assert meta["source_url"].endswith(f"/{source.revision}/{path}")
    assert meta["imports"] == ["Mathlib"]
    assert statement == """import Mathlib

open Nat

theorem LeanGolf.putnambench.putnam_2000_a2 (x : Nat) :
  (let y := x; y) = x := by sorry
"""


def test_importer_restores_a_source_backed_answer():
    source = next(source for source in SOURCES if source.key == "putnambench")
    text = """import Mathlib
abbrev putnam_2000_a1_solution : Nat := sorry
-- 7
theorem putnam_2000_a1 : putnam_2000_a1_solution = 7 := rfl
"""
    [(name, (meta, statement))] = extract(source, Path("lean4/src/putnam_2000_a1.lean"), text)
    assert name == "putnam_2000_a1"
    assert "abbrev putnam_2000_a1_solution : Nat :=\n  7" in statement
    assert statement.endswith(f"theorem {meta['name']} : putnam_2000_a1_solution = 7 := by sorry\n")


def test_importer_keeps_compfiles_context_and_credit():
    source = next(source for source in SOURCES if source.key == "compfiles")
    text = """/-
Copyright (c) 2024 Formalizer. All rights reserved.
Authors: Formalizer
-/
public import Mathlib.Data.Nat.Basic
public meta import Mathlib.Tactic
public import ProblemExtraction

namespace Example
variable (x : Nat)
determine result : Nat := 0
problem comp2026_p1 : x + result = x := by simp [result]
end Example
"""
    [(_, (meta, statement))] = extract(source, Path("Compfiles/Example2026P1.lean"), text)
    assert meta["imports"] == ["Mathlib.Data.Nat.Basic"]
    assert meta["credit"] == "Copyright (c) 2024 Formalizer. All rights reserved. Authors: Formalizer"
    assert meta["difficulty"] == "Example"
    assert "namespace Example\n\nvariable (x : Nat)\n\nabbrev result" in statement
    assert statement.endswith(f"theorem _root_.{meta['name']} : x + result = x := by sorry\n")
