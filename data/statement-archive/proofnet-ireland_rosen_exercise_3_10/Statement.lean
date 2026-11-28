import Mathlib

open Real

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.ireland_rosen_exercise_3_10 {n : ℕ} (hn0 : ¬ n.Prime) (hn1 : n ≠ 4) :
  Nat.factorial (n-1) ≡ 0 [MOD n] := by sorry
