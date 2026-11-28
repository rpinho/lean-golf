import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

abbrev I : Set ℝ := Icc 0 1

theorem LeanGolf.proofnet.munkres_exercise_24_3a (f : I → I) (hf : Continuous f) :
  ∃ (x : I), f x = x := by sorry
