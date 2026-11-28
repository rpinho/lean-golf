import Mathlib

open Fintype Subgroup Set Polynomial Ideal

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.dummit_foote_exercise_2_1_13 (H : AddSubgroup ℚ) {x : ℚ}
  (hH : x ∈ H → (1 / x) ∈ H):
  H = ⊥ ∨ H = ⊤ := by sorry
