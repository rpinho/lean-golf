import Mathlib

noncomputable section

open Topology Filter Polynomial Set

abbrev putnam_2001_b3_solution : ℝ :=
  3

theorem LeanGolf.putnambench.putnam_2001_b3
: ∑' n : Set.Ici 1, ((2 : ℝ) ^ (round (Real.sqrt n)) + (2 : ℝ) ^ (-round (Real.sqrt n))) / 2 ^ (n : ℝ) = putnam_2001_b3_solution := by sorry
