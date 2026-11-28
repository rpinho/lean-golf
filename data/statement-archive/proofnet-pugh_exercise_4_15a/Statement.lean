import Mathlib

open Filter Real Function

open scoped Topology

noncomputable section

theorem LeanGolf.proofnet.pugh_exercise_4_15a {α : Type*}
  (a b : ℝ) (F : Set (ℝ → ℝ)) :
  (∀ x : ℝ, ∀ ε > 0, ∃ U ∈ (𝓝 x),
  (∀ y z : U, ∀ f : ℝ → ℝ, f ∈ F → (dist (f y) (f z) < ε)))
  ↔
  ∃ (μ : ℝ → ℝ), ∀ (x : ℝ), (0 : ℝ) ≤ μ x ∧ Tendsto μ (𝓝 0) (𝓝 0) ∧
  (∀ (s t : ℝ) (f : ℝ → ℝ), f ∈ F → |(f s) - (f t)| ≤ μ (|s - t|)) := by sorry
