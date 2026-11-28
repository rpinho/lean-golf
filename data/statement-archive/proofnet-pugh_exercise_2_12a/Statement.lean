import Mathlib

open Filter Real Function

open scoped Topology

noncomputable section

theorem LeanGolf.proofnet.pugh_exercise_2_12a (f : ℕ → ℕ) (p : ℕ → ℝ) (a : ℝ)
  (hf : Injective f) (hp : Tendsto p atTop (𝓝 a)) :
  Tendsto (λ n => p (f n)) atTop (𝓝 a) := by sorry
