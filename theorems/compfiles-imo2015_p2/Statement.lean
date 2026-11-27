import Mathlib.Tactic

noncomputable section

namespace Imo2015P2

abbrev SolutionSet : Set (ℤ × ℤ × ℤ) := {
  (2, 2, 2),
  (2, 2, 3), (2, 3, 2), (3, 2, 2),
  (2, 6, 11), (6, 11, 2), (11, 2, 6),
  (11, 6, 2), (6, 2, 11), (2, 11, 6),
  (3, 5, 7), (5, 7, 3), (7, 3, 5),
  (7, 5, 3), (5, 3, 7), (3, 7, 5)
}

def is_power_of_two (n : ℤ) : Prop := ∃ m : ℕ, n = 2 ^ m

theorem _root_.LeanGolf.compfiles.imo2015_p2 (a b c : ℤ) :
    (a,b,c) ∈ SolutionSet ↔
      0 < a ∧ 0 < b ∧ 0 < c ∧
      is_power_of_two (a * b - c) ∧
      is_power_of_two (b * c - a) ∧
      is_power_of_two (c * a - b) := by sorry
