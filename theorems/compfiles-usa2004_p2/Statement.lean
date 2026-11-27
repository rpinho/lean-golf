import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.CharP.Defs
import Mathlib.Algebra.GCDMonoid.Finset
import Mathlib
import Mathlib.Order.ConditionallyCompleteLattice.Basic
import Mathlib.Tactic.NormNum.DivMod
import Mathlib.Tactic.Ring

namespace Usa2004P2

variable {n : ℕ} {a : Fin n → ℤ} {S : Set ℤ}

theorem _root_.LeanGolf.compfiles.usa2004_p2 {n : ℕ} (a : Fin n → ℤ) (S : Set ℤ)
    (hgcd : Finset.univ.gcd a = 1)
    (ha : ∀ i, a i ∈ S)
    (hdiff : ∀ i j, a i - a j ∈ S)
    (hcond : ∀ x y : ℤ, x ∈ S → y ∈ S → x + y ∈ S → x - y ∈ S) :
    S = Set.univ := by sorry
