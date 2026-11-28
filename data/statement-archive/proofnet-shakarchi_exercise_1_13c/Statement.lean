import Mathlib

open Complex Filter Function Metric Finset

open scoped BigOperators Topology

theorem LeanGolf.proofnet.shakarchi_exercise_1_13c {f : ℂ → ℂ} (Ω : Set ℂ) (a b : Ω) (h : IsOpen Ω)
  (hf : DifferentiableOn ℂ f Ω) (hc : ∃ (c : ℝ), ∀ z ∈ Ω, norm (f z) = c) :
  f a = f b := by sorry
