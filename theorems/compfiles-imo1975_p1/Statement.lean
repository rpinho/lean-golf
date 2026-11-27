import Mathlib
import Mathlib.Algebra.Order.Rearrangement
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Order.Interval.Finset.Nat

namespace Imo1975P1

variable (n : ℕ) (σ : Equiv.Perm ℕ) (x y : ℕ → ℝ)

theorem _root_.LeanGolf.compfiles.imo1975_p1
    (hx : AntitoneOn x (Finset.Icc 1 n)) (hy : AntitoneOn y (Finset.Icc 1 n))
    (hσ : {x | σ x ≠ x} ⊆ Finset.Icc 1 n) :
    ∑ i ∈ Finset.Icc 1 n, (x i - y i) ^ 2 ≤ ∑ i ∈ Finset.Icc 1 n, (x i - y (σ i)) ^ 2 := by sorry
