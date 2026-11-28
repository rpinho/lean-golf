import Mathlib

open Filter Real Function

open scoped Topology

noncomputable section

theorem LeanGolf.proofnet.pugh_exercise_2_41 (m : ℕ) {X : Type*} [NormedSpace ℝ ((Fin m) → ℝ)] :
  IsCompact (Metric.closedBall 0 1) := by sorry
