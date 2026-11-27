import Mathlib.Tactic

noncomputable section

namespace Imo1979P5

abbrev solution_set : Set ℝ := {0, 1, 4, 9, 16, 25}

theorem _root_.LeanGolf.compfiles.imo1979_p5 (a : ℝ) :
  (∃ x1 x2 x3 x4 x5 : ℝ,
    x1 ≥ 0 ∧ x2 ≥ 0 ∧ x3 ≥ 0 ∧ x4 ≥ 0 ∧ x5 ≥ 0 ∧
    x1 + 2*x2 + 3*x3 + 4*x4 + 5*x5 = a ∧
    x1 + 2^3*x2 + 3^3*x3 + 4^3*x4 + 5^3*x5 = a^2 ∧
    x1 + 2^5*x2 + 3^5*x3 + 4^5*x4 + 5^5*x5 = a^3 ) ↔ a ∈ solution_set := by sorry
