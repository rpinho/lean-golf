import Mathlib

open Topology Filter Matrix Set

theorem LeanGolf.putnambench.putnam_2011_b6
(p : ℕ)
(hp : Odd p ∧ Nat.Prime p)
: {n ∈ Finset.range p | ¬ p ∣ ∑ k : Finset.range p, Nat.factorial k * n^(k : ℕ)}.card ≥ (p + 1)/2 := by sorry
