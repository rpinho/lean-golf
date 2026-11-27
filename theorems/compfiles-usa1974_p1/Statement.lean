import Mathlib.Data.Int.Basic
import Mathlib.Algebra.Polynomial.Div

open Int

open Polynomial

namespace Usa1974P1

theorem _root_.LeanGolf.compfiles.usa1974_p1 {P : Polynomial ℤ} (a b c : ℤ) (h_neq : a ≠ b ∧ b ≠ c ∧ c ≠ a) :
  ¬(P.eval a = b ∧ P.eval b = c ∧ P.eval c = a) := by sorry
