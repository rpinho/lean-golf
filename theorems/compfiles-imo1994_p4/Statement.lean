import Mathlib.Tactic

noncomputable section

namespace Imo1994P4

abbrev SolutionSet : Set (ℤ × ℤ) := {
  (2, 2), (5, 3), (5, 2), (1, 3), (1, 2),
  (3, 5), (2, 5), (3, 1), (2, 1)
}

theorem _root_.LeanGolf.compfiles.imo1994_p4 (m n : ℤ) :
    (m, n) ∈ SolutionSet ↔
    0 < m ∧ 0 < n ∧ (m * n - 1) ∣ (n^3 + 1) := by sorry
