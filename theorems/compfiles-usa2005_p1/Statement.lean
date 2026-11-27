import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Data.Finset.NatDivisors
import Mathlib.Data.Finset.Sort
import Mathlib
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum.Ineq
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Zify

noncomputable section

namespace Usa2005P1

def R (a b : ℕ) : Prop := ¬ Nat.Coprime a b

def GoodCircle (n : ℕ) : Prop :=
  ∃ l : List ℕ, l.Nodup ∧ l ≠ [] ∧
    (∀ d : ℕ, d ∈ l ↔ d ∣ n ∧ 1 < d) ∧
    l.IsChain R ∧
    ∀ a ∈ l.getLast?, ∀ b ∈ l.head?, R a b

abbrev SolutionSet : Set ℕ :=
  {n | 1 < n ∧ ¬ n.Prime ∧ ¬ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ p ≠ q ∧ n = p * q}

theorem _root_.LeanGolf.compfiles.usa2005_p1 (n : ℕ) (hn : 1 < n) (hnp : ¬ n.Prime) :
    GoodCircle n ↔ n ∈ SolutionSet := by sorry
