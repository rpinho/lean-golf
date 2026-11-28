import Mathlib

open Real Nat
open scoped BigOperators

theorem LeanGolf.proofnet.ireland_rosen_exercise_4_5 {p t : ℕ} (hp0 : p.Prime) (hp1 : p = 4 * t + 3)
  (a : (ZMod p)ˣ) :
  IsPrimitiveRoot (a : ZMod p) (p - 1) ↔
    IsPrimitiveRoot (- (a : ZMod p)) ((p - 1) / 2) := by sorry
