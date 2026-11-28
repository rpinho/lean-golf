import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_4_2_14 {G : Type*} [Fintype G] [Group G]
  (hG : ¬ (card G).Prime) (hG_ne_one : card G ≠ 1)
  (hG1 : ∀ k : ℕ, k ∣ card G →
    ∃ (H : Subgroup G) (fH : Fintype H), @card H fH = k) :
  ¬ IsSimpleGroup G := by sorry
