import Mathlib

open Filter Set

theorem LeanGolf.proofnet.cambridge_tripos_exercise_2022_IB_3_II_13G_a_i (U : Set ℂ) (hU : IsOpen U)
  (hU1 : Nonempty U) (hU2 : IsConnected U) (f : ℕ → ℂ → ℂ) (f' : ℂ → ℂ)
  (hf : ∀ n : ℕ, DifferentiableOn ℂ (f n) U)
  (hf1 : ∀ X ⊂ U, CompactSpace X →
  (TendstoUniformly (λ n => restrict X (f n)) (restrict X f') atTop)) :
  DifferentiableOn ℂ f' U := by sorry
