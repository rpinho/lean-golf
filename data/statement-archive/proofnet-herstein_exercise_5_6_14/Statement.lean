import Mathlib

open Fintype Set Real Ideal Polynomial

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.herstein_exercise_5_6_14 {p m n: ℕ} (hp : Nat.Prime p) {F : Type*}
  [Field F] [CharP F p] (hm : m = p ^ n) :
  card (rootSet (X ^ m - X : Polynomial F) F) = m := by sorry
