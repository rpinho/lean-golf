import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.rudin_exercise_3_13
  (a b : ℕ → ℝ)
  (ha : ∃ y, (Tendsto (λ n => (∑ i ∈ (range n), |a i|)) atTop (𝓝 y)))
  (hb : ∃ y, (Tendsto (λ n => (∑ i ∈ (range n), |b i|)) atTop (𝓝 y))) :
  ∃ y, (Tendsto (λ n => (∑ i ∈ (range n),
  λ i => (∑ j ∈ range (i + 1), a j * b (i - j)))) atTop (𝓝 y)) := by sorry
