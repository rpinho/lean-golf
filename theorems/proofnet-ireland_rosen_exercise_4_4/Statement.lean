import Mathlib

open Real
open scoped BigOperators

theorem LeanGolf.proofnet.ireland_rosen_exercise_4_4 {p t : ℕ} (hp0 : p.Prime) (hp1 : p = 4 * t + 1)
  (a : ZMod p) :
  IsPrimitiveRoot a (p - 1) ↔ IsPrimitiveRoot (-a) (p - 1) := by sorry
