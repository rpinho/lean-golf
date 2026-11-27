import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.Data.Nat.Prime.Factorial
import Mathlib.NumberTheory.Bertrand

noncomputable section

namespace Usa2024P1

def Good (n : ℕ) : Prop :=
  ∀ a ∈ (Nat.factorial n).divisors, ∀ b ∈ (Nat.factorial n).divisors,
    ∀ c ∈ (Nat.factorial n).divisors,
    a < b → b < c →
    (∀ d ∈ (Nat.factorial n).divisors, d ≤ a ∨ b ≤ d) →
    (∀ d ∈ (Nat.factorial n).divisors, d ≤ b ∨ c ≤ d) →
    b - a ≤ c - b

abbrev solution_set : Set ℕ := {3, 4}

theorem _root_.LeanGolf.compfiles.usa2024_p1 (n : ℕ) (hn : 3 ≤ n) : n ∈ solution_set ↔ Good n := by sorry
