import Mathlib.Tactic

namespace Imo1972P1

theorem _root_.LeanGolf.compfiles.imo1972_p1 (S : Finset ℕ)
    (Scard : S.card = 10)
    (Sdigits : ∀ n ∈ S, (Nat.digits 10 n).length = 2) :
    ∃ S1 S2 : Finset ℕ, S1 ⊆ S ∧ S2 ⊆ S ∧
       Disjoint S1 S2 ∧ ∑ n ∈ S1, n = ∑ n ∈ S2, n := by sorry
