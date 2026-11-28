import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_4_5_14 {G : Type*} [Group G] [Fintype G]
  (hG : card G = 312) :
  ∃ (p : ℕ) (P : Sylow p G), p.Prime ∧ (p ∣ card G) ∧ P.Normal := by sorry
