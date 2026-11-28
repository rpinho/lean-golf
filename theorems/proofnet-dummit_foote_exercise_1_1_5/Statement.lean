import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_1_1_5 (n : ℕ) (hn : 1 < n) :
  ¬ (∀ x : ZMod n, ∃ y : ZMod n, x * y = (1 : ZMod n) ∧ y * x = 1) := by sorry
