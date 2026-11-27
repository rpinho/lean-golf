import Mathlib

noncomputable section

noncomputable abbrev putnam_2015_a4_solution : ℝ :=
  4 / 7

theorem LeanGolf.putnambench.putnam_2015_a4
(S : ℝ → Set ℤ)
(f : ℝ → ℝ)
(p : ℝ → Prop)
(hS : S = fun (x : ℝ) ↦ {n : ℤ | n > 0 ∧ Even ⌊n * x⌋})
(hf : f = fun (x : ℝ) ↦ ∑' n : S x, 1 / 2 ^ (n : ℤ))
(hp : ∀ l, p l ↔ ∀ x ∈ Set.Ico 0 1, f x ≥ l)
: IsGreatest p putnam_2015_a4_solution := by sorry
