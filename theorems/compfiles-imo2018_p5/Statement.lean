import Mathlib.Tactic

namespace Imo2018P5

theorem _root_.LeanGolf.compfiles.imo2018_p5
    (a : ℕ → ℤ)
    (apos : ∀ n, 0 < a n)
    (N : ℕ)
    (hN : 0 < N)
    (h : ∀ n, N ≤ n →
      ∃ z : ℤ,
        z = ∑ i ∈ Finset.range n, (a i : ℚ) / a ((i + 1) % n))
    : ∃ M, ∀ m, M ≤ m → a m = a (m + 1) := by sorry
