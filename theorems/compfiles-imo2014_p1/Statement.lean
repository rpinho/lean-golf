import Mathlib.Tactic

namespace Imo2014P1

theorem _root_.LeanGolf.compfiles.imo2014_p1 (a : ℕ → ℤ) (apos : ∀ i, 0 < a i) (ha : ∀ i, a i < a (i + 1)) :
    ∃! n : ℕ, 0 < n ∧
              n * a n < (∑ i ∈ Finset.range (n + 1), a i) ∧
              (∑ i ∈ Finset.range (n + 1), a i) ≤ n * a (n + 1) := by sorry
