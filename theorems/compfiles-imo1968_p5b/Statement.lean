import Mathlib.Tactic

noncomputable section

namespace Imo1968P5

abbrev P (a : ℝ) (f : ℝ → ℝ) : Prop :=
  0 < a ∧
  ∀ x, (f x)^2 ≤ f x ∧ f (x + a) = 1/2 + √(f x - (f x)^2)

noncomputable abbrev solution_func : ℝ → ℝ := fun x ↦
 if Even ⌊x⌋ then 1 else 1/2

theorem _root_.LeanGolf.compfiles.imo1968_p5b :
    P 1 solution_func ∧ ¬∃c, solution_func = Function.const ℝ c := by sorry
