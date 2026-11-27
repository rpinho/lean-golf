import Mathlib

open Nat Topology Filter

theorem LeanGolf.putnambench.putnam_1967_b5
(n : ℕ)
(hn : n > 0)
: (1 : ℚ)/2 = ∑ i ∈ Finset.range n, (Nat.choose (n + i - 1) i) * (2 : ℚ)^(-(n : ℤ) - i) := by sorry
