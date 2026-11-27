import Mathlib

open Fintype Set Real Ideal Polynomial

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.herstein_exercise_2_5_30 {G : Type*} [Group G] [Fintype G]
  {p m : ℕ} (hp : Nat.Prime p) (hp1 : ¬ p ∣ m) (hG : card G = p*m)
  {H : Subgroup G} [Fintype H] [H.Normal] (hH : card H = p):
  Subgroup.Characteristic H := by sorry
