import Mathlib

noncomputable section

open scoped NNReal

namespace Imo1986P5

structure IsGood (f : ℝ≥0 → ℝ≥0) : Prop where
  map_add_rev x y : f (x * f y) * f y = f (x + y)
  map_two : f 2 = 0
  map_ne_zero : ∀ x < 2, f x ≠ 0

noncomputable abbrev SolutionSet : Set (ℝ≥0 → ℝ≥0) := { fun x ↦ 2 / (2 - x) }

theorem _root_.LeanGolf.compfiles.imo1986_p5 {f : ℝ≥0 → ℝ≥0} : IsGood f ↔ f ∈ SolutionSet := by sorry
