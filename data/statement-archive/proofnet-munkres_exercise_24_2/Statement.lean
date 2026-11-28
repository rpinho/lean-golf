import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_24_2 {f : (Metric.sphere 0 1 : Set ℝ) → ℝ}
  (hf : Continuous f) : ∃ x, f x = f (-x) := by sorry
