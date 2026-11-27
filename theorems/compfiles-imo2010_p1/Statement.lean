import Mathlib.Tactic

noncomputable section

namespace Imo2010P1

abbrev solution_set : Set (ℝ → ℝ) :=
  { f | (∃ C, ⌊C⌋ = 1 ∧ f = Function.const _ C) ∨ f = Function.const _ 0 }

theorem _root_.LeanGolf.compfiles.imo2010_p1 (f : ℝ → ℝ) :
    f ∈ solution_set ↔ ∀ x y, f (⌊x⌋ * y) = f x * ⌊f y⌋ := by sorry
