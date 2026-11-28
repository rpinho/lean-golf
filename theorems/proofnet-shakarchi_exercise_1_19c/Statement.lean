import Mathlib

open Complex Filter Function Metric Finset
open scoped BigOperators Topology

theorem LeanGolf.proofnet.shakarchi_exercise_1_19c (z : ℂ) (hz : ‖z‖ = 1) (s : ℕ → ℂ)
    (h : s = (λ n => ∑ i ∈ (range n), z ^ (i + 1) / (i + 1))) :
    (∃ z₀, Tendsto s atTop (𝓝 z₀)) ↔ z ≠ 1 := by sorry
