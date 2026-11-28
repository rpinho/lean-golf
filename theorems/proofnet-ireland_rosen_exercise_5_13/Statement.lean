import Mathlib

open Real
open scoped BigOperators

theorem LeanGolf.proofnet.ireland_rosen_exercise_5_13 {p : ℕ} {x : ℤ}
    (hp : Nat.Prime p)
    (hpx : (p : ℤ) ∣ (x^4 - x^2 + 1)) : (p : ℤ) ≡ 1 [ZMOD 12] := by sorry
