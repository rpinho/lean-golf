import Mathlib.Data.Nat.Digits.Lemmas

noncomputable section

open Nat

namespace Imo1960P1

def sumOfSquares (L : List ℕ) : ℕ :=
  (L.map fun x => x * x).sum

def ProblemPredicate (n : ℕ) : Prop :=
  (Nat.digits 10 n).length = 3 ∧ 11 ∣ n ∧ n / 11 = sumOfSquares (Nat.digits 10 n)

abbrev SolutionPredicate (n : ℕ) : Prop :=
  n = 550 ∨ n = 803

theorem _root_.LeanGolf.compfiles.imo1960_p1 (n : ℕ) : ProblemPredicate n ↔ SolutionPredicate n := by sorry
