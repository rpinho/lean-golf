import Mathlib

noncomputable section

open Nat

abbrev putnam_2023_b2_solution : ℕ :=
  3

theorem LeanGolf.putnambench.putnam_2023_b2
: sInf {(digits 2 (2023*n)).sum | n > 0} = putnam_2023_b2_solution := by sorry
