import Mathlib

noncomputable section

open Filter Set TopologicalSpace

open Topology

noncomputable section

abbrev I : Set ℝ := Icc 0 1

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_29_4 [TopologicalSpace (ℕ → I)] :
  ¬ LocallyCompactSpace (ℕ → I) := by sorry
