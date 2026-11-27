import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Tactic

namespace Imo1966P4

theorem _root_.LeanGolf.compfiles.imo1966_p4 (n : ℕ) (x : ℝ)
    (hx : ∀ t : ℕ, ∀ k : ℤ, x ≠ k * Real.pi / 2^t) :
    ∑ i ∈ Finset.range n, 1 / Real.sin (2^(i + 1) * x) =
    Real.cot x - Real.cot (2^n * x) := by sorry
