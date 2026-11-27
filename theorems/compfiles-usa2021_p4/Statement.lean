import Mathlib.Tactic
import Mathlib.Data.Nat.Nth
import Mathlib.NumberTheory.ArithmeticFunction.Misc

noncomputable section

namespace Usa2021P4

def IsValid (S : Finset ℕ) : Prop :=
  (∀ s ∈ S, 0 < s) ∧ ∀ s ∈ S, ∀ d : ℕ, 0 < d → d ∣ s → ∃! t : ℕ, t ∈ S ∧ Nat.gcd s t = d

abbrev solution_set : Set ℕ := {n | n = 0 ∨ ∃ k : ℕ, n = 2 ^ k}

theorem _root_.LeanGolf.compfiles.usa2021_p4 (n : ℕ) :
    n ∈ solution_set ↔ ∃ S : Finset ℕ, IsValid S ∧ S.card = n := by sorry
