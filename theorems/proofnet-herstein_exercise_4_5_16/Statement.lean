import Mathlib

open Fintype Set Real Ideal Polynomial
open scoped BigOperators

theorem LeanGolf.proofnet.herstein_exercise_4_5_16 {p n: ℕ} (hp : Nat.Prime p)
  {q : Polynomial (ZMod p)} (hq : Irreducible q) (hn : q.degree = n) :
  (∃ is_fin : Fintype $ Polynomial (ZMod p) ⧸ span ({q}),
  @card (Polynomial (ZMod p) ⧸ span {q}) is_fin = p ^ n) ∧
  IsField (Polynomial (ZMod p) ⧸ span {q}) := by sorry
