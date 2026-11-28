import Mathlib

noncomputable section

open Filter Set TopologicalSpace

open Topology

noncomputable section

abbrev I : Set ℝ := Icc 0 1

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_24_3a [TopologicalSpace I] [CompactSpace I]
  (f : I → I) (hf : Continuous f) :
  ∃ (x : I), f x = x := by sorry
