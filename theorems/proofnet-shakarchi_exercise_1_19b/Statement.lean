import Mathlib

open Complex Filter Function Metric Finset
open scoped BigOperators Topology

theorem LeanGolf.proofnet.shakarchi_exercise_1_19b (z : ℂ) (hz : ‖z‖ = 1) (s : ℕ → ℂ)
    (h : s = (λ n => ∑ i ∈ (range n), z ^ (i + 1) / (i + 1) ^ 2)) :
    ∃ y, Tendsto s atTop (𝓝 y) := by sorry
