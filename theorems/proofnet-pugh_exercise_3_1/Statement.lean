import Mathlib

open Filter Real Function

open scoped Topology

noncomputable section

theorem LeanGolf.proofnet.pugh_exercise_3_1 {f : ℝ → ℝ}
  (hf : ∀ x y, |f x - f y| ≤ |x - y| ^ 2) :
  ∃ c, f = λ x => c := by sorry
