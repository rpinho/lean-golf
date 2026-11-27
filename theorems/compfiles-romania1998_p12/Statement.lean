import Mathlib
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

noncomputable section

namespace Romania1998P12

abbrev solution_set : Set (ℝ → ℝ) :=
  { u | ∃ k : ℝ, ∀ x : ℝ, u x = Real.exp (k * x) }

theorem _root_.LeanGolf.compfiles.romania1998_p12 (u : ℝ → ℝ) :
    (∃ f : ℝ → ℝ, (StrictMono f ∨ StrictAnti f)
          ∧ ∀ x y : ℝ, f (x + y) = f x * u y + f y) ↔
    u ∈ solution_set := by sorry
