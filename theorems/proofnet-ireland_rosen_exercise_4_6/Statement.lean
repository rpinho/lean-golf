import Mathlib

open Real
open scoped BigOperators

theorem LeanGolf.proofnet.ireland_rosen_exercise_4_6 {p n : ℕ} (hp : p.Prime) (hpn : p = 2 ^ n + 1)
    (hn : 2 ≤ n) :
    IsPrimitiveRoot (3 : ZMod p) (p - 1) := by sorry
