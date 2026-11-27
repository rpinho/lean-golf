import Mathlib

open Complex Filter Function Metric Finset

open scoped BigOperators Topology

theorem LeanGolf.proofnet.shakarchi_exercise_3_3 (a : ℝ) (ha : 0 < a) :
    Tendsto (λ y => ∫ x in -y..y, Real.cos x / (x ^ 2 + a ^ 2))
    atTop (𝓝 (Real.pi * (Real.exp (-a) / a))) := by sorry
