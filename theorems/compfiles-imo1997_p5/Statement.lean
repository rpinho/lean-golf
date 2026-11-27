import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Analysis.Normed.Ring.Lemmas
import Mathlib
import Mathlib.Tactic.IntervalCases

noncomputable section

namespace Imo1997P5

abbrev solution_set : Set (ℕ × ℕ) := {(1, 1), (16, 2), (27, 3)}

theorem _root_.LeanGolf.compfiles.imo1997_p5 (a b : ℕ) (ha : 0 < a) (hb : 0 < b) :
    a ^ (b ^ 2) = b ^ a ↔ (a, b) ∈ solution_set := by sorry
