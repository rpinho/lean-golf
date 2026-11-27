import Mathlib.Tactic
import Mathlib.Analysis.MeanInequalities

namespace Imo2012P2

universe u v

theorem _root_.LeanGolf.compfiles.imo2012_p2 (n : ℕ) (hn : 3 ≤ n) (a : Finset.Icc 2 n → ℝ)
    (apos : ∀ i, 0 < a i) (aprod : ∏ i, a i = 1) :
    (n:ℝ)^n < ∏ i, (1 + a i)^i.val := by sorry
