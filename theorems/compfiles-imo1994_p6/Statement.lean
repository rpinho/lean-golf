import Mathlib.Tactic
import Mathlib.Data.PNat.Basic
import Mathlib.Data.Nat.Nth

noncomputable section

namespace Imo1994P6

def IsProductOfkDistinctMembers (x : ℕ) (k : ℕ) (S : Set ℕ) : Prop :=
  ∃ S' : Finset S, S'.card = k ∧ x = ∏ p ∈ S', p.val

def Primes := { p : ℕ | p.Prime }

instance : Infinite Primes := Nat.infinite_setOfPred_prime.to_subtype

theorem _root_.LeanGolf.compfiles.imo1994_p6 :
  ∃ A : Set ℕ, (∀ a ∈ A, 0 < a) ∧ ∀ S : Set ℕ, Infinite S ∧ (∀ p ∈ S, p.Prime) →
    ∃ k m n : ℕ, 2 ≤ k ∧
      (m ∈ A ∧ 0 < m ∧ IsProductOfkDistinctMembers m k S) ∧
      (n ∉ A ∧ 0 < n ∧ IsProductOfkDistinctMembers n k S) := by sorry
