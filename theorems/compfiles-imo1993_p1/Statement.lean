import Mathlib.Tactic

noncomputable section

namespace Imo1993P1

open Polynomial

noncomputable def f (n : ℕ) : ℤ[X] := X^n + 5*X^(n-1) + 3

def isConstant {R : Type*} [Semiring R] (p : R[X]) : Prop := ∀ i > 0, p.coeff i = 0

theorem _root_.LeanGolf.compfiles.imo1993_p1 : ∀ n > 1, ¬∃ p q : ℤ[X], f n = p*q ∧ ¬ isConstant p ∧ ¬ isConstant q := by sorry
