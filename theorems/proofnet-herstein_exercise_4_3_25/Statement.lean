import Mathlib

open Fintype Set Real Ideal Polynomial
open scoped BigOperators

theorem LeanGolf.proofnet.herstein_exercise_4_3_25
    (I : TwoSidedIdeal (Matrix (Fin 2) (Fin 2) ℝ)) :
    I = ⊥ ∨ I = ⊤ := by sorry
