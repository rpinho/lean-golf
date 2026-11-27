import Mathlib

namespace Imo1985P4

universe u v w

theorem _root_.LeanGolf.compfiles.imo1985_p4 (M : Finset ℕ) (Mcard : M.card = 1985) (Mpos : ∀ m ∈ M, 0 < m)
    (Mdivisors : ∀ m ∈ M, ∀ n, n ∈ m.primeFactors → n ≤ 23)
    : ∃ M' : Finset ℕ, M' ⊆ M ∧ M'.card = 4 ∧ ∃ k, M'.prod id = k^4 := by sorry
