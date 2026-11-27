import Mathlib
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Arctan
import Mathlib.Analysis.MeanInequalities
import Mathlib.Tactic

namespace Usa1998P3

theorem _root_.LeanGolf.compfiles.usa1998_p3
    (n : ℕ)
    (a : ℕ → ℝ)
    (ha : ∀ i ∈ Finset.range (n + 1), a i ∈ Set.Ioo 0 (Real.pi / 2))
    (hs : n - 1 ≤ ∑ i ∈ Finset.range (n + 1), Real.tan (a i - (Real.pi / 4)))
    : n ^ (n + 1) ≤ ∏ i ∈ Finset.range (n + 1), Real.tan (a i) := by sorry
