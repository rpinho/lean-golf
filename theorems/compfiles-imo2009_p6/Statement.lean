import Mathlib.Tactic
import Mathlib.Data.Fin.Tuple.Sort

namespace Imo2009P6

theorem _root_.LeanGolf.compfiles.imo2009_p6 (n : ℕ) (hn : 0 < n)
    (a : Fin n → ℤ)
    (ainj : a.Injective)
    (apos : ∀ i, 0 < a i)
    (M : Finset ℤ)
    (Mpos : ∀ m ∈ M, 0 < m)
    (Mcard : M.card = n - 1)
    (hM : ∑ i, a i ∉ M)
    : ∃ p : Equiv.Perm (Fin n),
        ∀ i : Fin n,
          ∑ j ∈ Finset.univ.filter (· ≤ i), a (p j) ∉ M := by sorry
