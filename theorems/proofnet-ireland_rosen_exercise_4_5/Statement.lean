import Mathlib

open Real

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.ireland_rosen_exercise_4_5 {p t : ℕ} (hp0 : p.Prime) (hp1 : p = 4*t + 3)
  (a : ZMod p) :
  IsPrimitiveRoot a p ↔ ((-a) ^ ((p-1)/2) = 1 ∧ ∀ (k : ℕ), k < (p-1)/2 → (-a)^k ≠ 1) := by sorry
