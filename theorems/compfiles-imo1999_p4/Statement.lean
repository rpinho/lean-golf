import Mathlib
import Mathlib.Tactic

noncomputable section

namespace Imo1999P4

abbrev SolutionSet : Set (ℕ × ℕ) := {(2,2), (3,3)} ∪ {(n,p) | n = 1 ∧ p.Prime}

theorem _root_.LeanGolf.compfiles.imo1999_p4 (n p : ℕ) :
    (n,p) ∈ SolutionSet ↔
    0 < n ∧ n ≤ 2 * p ∧ p.Prime ∧ n^(p - 1) ∣ (p - 1)^n + 1 := by sorry
