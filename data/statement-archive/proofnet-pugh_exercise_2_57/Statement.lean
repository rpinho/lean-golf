import Mathlib

open Filter Real Function

open scoped Topology

noncomputable section

theorem LeanGolf.proofnet.pugh_exercise_2_57 {X : Type*} [TopologicalSpace X]
  : ∃ (S : Set X), IsConnected S ∧ ¬ IsConnected (interior S) := by sorry
