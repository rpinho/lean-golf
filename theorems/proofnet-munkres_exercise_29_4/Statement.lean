import Mathlib

open Filter Set TopologicalSpace
open scoped Topology BoundedContinuousFunction

abbrev I : Set ℝ := Icc 0 1

theorem LeanGolf.proofnet.munkres_exercise_29_4 :
    ¬ LocallyCompactSpace (ℕ →ᵇ I) := by sorry
