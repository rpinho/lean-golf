import Mathlib.Tactic

noncomputable section

namespace Imo1998P4

abbrev solution_set : Set (ℤ × ℤ) := {(11, 1), (49, 1)} ∪
  {(x,y) | ∃ k : ℤ , (0 < k ∧ x = 7 * k^2 ∧ y = 7 * k)}

theorem _root_.LeanGolf.compfiles.imo1998_p4 (a b : ℤ) :
    (0 < a ∧ 0 < b ∧ a * b^2 + b + 7 ∣ a^2 * b + a + b) ↔
    (a, b) ∈ solution_set := by sorry
