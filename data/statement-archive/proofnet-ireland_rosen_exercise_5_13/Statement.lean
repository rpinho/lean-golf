import Mathlib

open Real

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.ireland_rosen_exercise_5_13 {p x: ℤ} (hp : Prime p)
  (hpx : p ∣ (x^4 - x^2 + 1)) : p ≡ 1 [ZMOD 12] := by sorry
