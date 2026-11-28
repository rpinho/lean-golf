import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

theorem LeanGolf.proofnet.munkres_exercise_24_2
    {f : (Metric.sphere (0 : ℂ) 1 : Set ℂ) → ℝ}
    (hf : Continuous f) : ∃ x, f x = f (-x) := by sorry
