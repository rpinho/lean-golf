import Mathlib

open Complex Filter Function Metric Finset

open scoped BigOperators Topology

theorem LeanGolf.proofnet.shakarchi_exercise_2_13 {f : ℂ → ℂ}
    (hf : ∀ z₀ : ℂ, ∃ (s : Set ℂ) (c : ℕ → ℂ), IsOpen s ∧ z₀ ∈ s ∧
      ∀ z ∈ s, Tendsto (λ n => ∑ i ∈ range n, (c i) * (z - z₀)^i) atTop (𝓝 (f z₀))
      ∧ ∃ i, c i = 0) :
    ∃ (c : ℕ → ℂ) (n : ℕ), f = λ z => ∑ i ∈ range n, (c i) * z ^ n := by sorry
