import Mathlib

open Real
open scoped BigOperators

theorem LeanGolf.proofnet.ireland_rosen_exercise_4_8 {p : ℕ} (hp : Odd p) (hp' : p.Prime) (a : (ZMod p)ˣ) :
  IsPrimitiveRoot (a : ZMod p) (p - 1) ↔
    ∀ q : ℕ, q ∣ (p - 1) → q.Prime →
      ¬ ((a : ZMod p) ^ ((p - 1) / q) = 1) := by sorry
