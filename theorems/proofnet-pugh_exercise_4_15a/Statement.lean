import Mathlib

open Filter Real Function Set
open scoped Topology

theorem LeanGolf.proofnet.pugh_exercise_4_15a (a b : ℝ) (hab : a ≤ b) (f : Icc a b → ℝ) :
  UniformContinuous f ↔ ∃ (μ : ℝ → ℝ), (∀ x : ℝ, x > 0 → μ x > 0) ∧
  ContinuousOn μ (Ioi 0) ∧ StrictMonoOn μ (Ioi 0) ∧ Tendsto μ (𝓝[>] 0) (𝓝 0) ∧
  (∀ s t : Icc a b, |f s - f t| ≤ μ (|s - t|)) := by sorry
