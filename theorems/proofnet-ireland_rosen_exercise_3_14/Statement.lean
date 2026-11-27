import Mathlib

open Real

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.ireland_rosen_exercise_3_14 {p q n : ℕ} (hp0 : p.Prime ∧ p > 2)
  (hq0 : q.Prime ∧ q > 2) (hpq0 : p ≠ q) (hpq1 : p - 1 ∣ q - 1)
  (hn : n.gcd (p*q) = 1) :
  n^(q-1) ≡ 1 [MOD p*q] := by sorry
