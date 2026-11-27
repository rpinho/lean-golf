import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.rudin_exercise_3_1a
  (f : ℕ → ℝ)
  (h : ∃ (a : ℝ), Tendsto (λ (n : ℕ) => f n) atTop (𝓝 a))
  : ∃ (a : ℝ), Tendsto (λ (n : ℕ) => |f n|) atTop (𝓝 a) := by sorry
