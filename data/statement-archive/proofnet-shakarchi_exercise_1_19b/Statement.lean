import Mathlib

open Complex Filter Function Metric Finset

open scoped BigOperators Topology

theorem LeanGolf.proofnet.shakarchi_exercise_1_19b (z : ℂ) (hz : norm z = 1) (s : ℕ → ℂ)
    (h : s = (λ n => ∑ i ∈ (range n), i * z / i ^ 2)) :
    ∃ y, Tendsto s atTop (𝓝 y) := by sorry
