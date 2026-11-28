import Mathlib

open Real

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.ireland_rosen_exercise_4_8 {p a : ℕ} (hp : Odd p) :
  IsPrimitiveRoot a p ↔ (∀ q : ℕ, q ∣ (p-1) → q.Prime → ¬ a^(p-1) ≡ 1 [MOD p]) := by sorry
