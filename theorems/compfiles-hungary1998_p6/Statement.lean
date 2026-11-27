import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Tactic

namespace Hungary1998P6

theorem _root_.LeanGolf.compfiles.hungary1998_p6 (x y : ℤ) (z : ℕ) (hz : 1 < z) :
    ∑ i ∈ Finset.range 99, (x + i + 1)^2 ≠ y^z := by sorry
