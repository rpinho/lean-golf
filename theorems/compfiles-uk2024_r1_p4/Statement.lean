import Mathlib.Tactic

noncomputable section

namespace UK2024R1P4

abbrev SolutionSet : Set ℕ := {2, 3}

theorem _root_.LeanGolf.compfiles.uk2024_r1_p4 (n : ℕ) (hn : 0 < n) :
    n ∈ SolutionSet ↔ IsSquare (n * 2 ^ n + 1) := by sorry
