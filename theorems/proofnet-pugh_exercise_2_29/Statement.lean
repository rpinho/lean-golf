import Mathlib

open Filter Real Function

open scoped Topology

noncomputable section

theorem LeanGolf.proofnet.pugh_exercise_2_29 (M : Type*) [MetricSpace M]
  (O C : Set (Set M))
  (hO : O = {s | IsOpen s})
  (hC : C = {s | IsClosed s}) :
  ∃ f : O → C, Bijective f := by sorry
