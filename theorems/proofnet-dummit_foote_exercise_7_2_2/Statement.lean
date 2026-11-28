import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators nonZeroDivisors

theorem LeanGolf.proofnet.dummit_foote_exercise_7_2_2 {R : Type*} [CommRing R] (p : Polynomial R) :
    (∃ q : Polynomial R, q ≠ 0 ∧ p * q = 0) ↔
      (∃ b : R, b ≠ 0 ∧ b • p = 0) := by sorry
