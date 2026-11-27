import Mathlib.Tactic

namespace Canada1998P3

theorem _root_.LeanGolf.compfiles.canada1998_p3 (n : ℕ) (hn : 2 ≤ n) :
    (1/(n:ℝ)) * ∑ i ∈ Finset.range n, (1/(2 * (i:ℝ) + 2)) <
    (1/((n:ℝ) + 1)) * ∑ i ∈ Finset.range n, (1/(2 * (i:ℝ) + 1)) := by sorry
