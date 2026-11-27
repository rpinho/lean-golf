import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Algebra.Polynomial.Degree.Lemmas
import Mathlib.Data.List.TakeWhile
import Mathlib.Data.Nat.Digits.Lemmas
import Mathlib.Tactic.NormNum.Prime

noncomputable section

namespace Usa2019P3

open Polynomial

def K : Set ℕ := {n | 0 < n ∧ 7 ∉ Nat.digits 10 n}

abbrev solution_set : Set (Polynomial ℕ) :=
  {f | (∃ k : ℕ, k ∈ K ∧ f = C k) ∨
       (∃ e k : ℕ, k < 10 ^ e ∧ (k = 0 ∨ k ∈ K) ∧ f = C (10 ^ e) * X + C k)}

theorem _root_.LeanGolf.compfiles.usa2019_p3 (f : Polynomial ℕ) :
    (∀ n ∈ K, f.eval n ∈ K) ↔ f ∈ solution_set := by sorry
