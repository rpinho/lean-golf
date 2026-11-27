import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex

noncomputable section

open Real

namespace Imo1962P4

def ProblemEquation (x : ℝ) : Prop :=
  cos x ^ 2 + cos (2 * x) ^ 2 + cos (3 * x) ^ 2 = 1

abbrev solutionSet : Set ℝ :=
  {x : ℝ | ∃ k : ℤ, x = (2 * ↑k + 1) * π / 4 ∨ x = (2 * ↑k + 1) * π / 6}

theorem _root_.LeanGolf.compfiles.imo1962_p4 {x : ℝ} : ProblemEquation x ↔ x ∈ solutionSet := by sorry
