import Mathlib

open Filter Real Function

open scoped Topology

noncomputable section

theorem LeanGolf.proofnet.pugh_exercise_3_63b (p : ℝ) (f : ℕ → ℝ) (hp : p ≤ 1)
  (h : f = λ (k : ℕ) => (1 : ℝ) / (k * (log k) ^ p)) :
  ¬ ∃ l, Tendsto f atTop (𝓝 l) := by sorry
