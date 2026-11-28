import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_2_1_13 (H : AddSubgroup ℚ)
    (hH : ∀ ⦃x : ℚ⦄, x ∈ H → x ≠ 0 → (1 / x) ∈ H) :
    H = ⊥ ∨ H = ⊤ := by sorry
