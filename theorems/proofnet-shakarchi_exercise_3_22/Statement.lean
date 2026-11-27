import Mathlib

open Complex Filter Function Metric Finset

open scoped BigOperators Topology

theorem LeanGolf.proofnet.shakarchi_exercise_3_22 (D : Set ℂ) (hD : D = ball 0 1) (f : ℂ → ℂ)
    (hf : DifferentiableOn ℂ f D) (hfc : ContinuousOn f (closure D)) :
    ¬ ∀ z ∈ (sphere (0 : ℂ) 1), f z = 1 / z := by sorry
