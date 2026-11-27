import Mathlib
import Mathlib.Analysis.MeanInequalities

namespace Iran1998P3

theorem _root_.LeanGolf.compfiles.iran1998_p3
    (x : ℕ → ℝ)
    (x_positive : ∀ i, 0 < x i)
    (h : ∏ i ∈ Finset.range 4, x i = 1)
    : max (∑ i ∈ Finset.range 4, x i) (∑ i ∈ Finset.range 4, 1 / x i)
     ≤ ∑ i ∈ Finset.range 4, (x i)^(3 : ℝ) := by sorry
