import Mathlib.Data.Nat.Digits.Lemmas

noncomputable section

namespace Imo1962P1

open Nat

def ProblemPredicate (n : ℕ) : Prop :=
  (digits 10 n).headI = 6 ∧ ofDigits 10 ((digits 10 n).tail.concat 6) = 4 * n

abbrev solution : ℕ := 153846

theorem _root_.LeanGolf.compfiles.imo1962_p1 : IsLeast {n | ProblemPredicate n} solution := by sorry
