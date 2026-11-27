import Mathlib

theorem LeanGolf.inf_primes : ∀ n : ℕ, ∃ p : ℕ, n ≤ p ∧ Nat.Prime p :=
  Nat.exists_infinite_primes -- < & > are escaped in the card
