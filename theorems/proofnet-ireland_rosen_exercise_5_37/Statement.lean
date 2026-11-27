import Mathlib

open Real

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.ireland_rosen_exercise_5_37 {p q : ℕ} [Fact (p.Prime)] [Fact (q.Prime)] {a : ℤ}
  (ha : a < 0) (h0 : p ≡ q [ZMOD 4*a]) (h1 : ¬ ((p : ℤ) ∣ a)) :
  legendreSym p a = legendreSym q a := by sorry
