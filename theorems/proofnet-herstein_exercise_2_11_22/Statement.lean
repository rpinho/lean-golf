import Mathlib

open Fintype Set Real Ideal Polynomial

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.herstein_exercise_2_11_22 {p : ℕ} {n : ℕ} {G : Type*} [Fintype G]
  [Group G] (hp : Nat.Prime p) (hG : card G = p ^ n) {K : Subgroup G}
  [Fintype K] (hK : card K = p ^ (n-1)) :
  K.Normal := by sorry
