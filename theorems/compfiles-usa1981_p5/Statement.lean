import Mathlib.Tactic

namespace Usa1981P5

theorem _root_.LeanGolf.compfiles.usa1981_p5 (x : ℝ) (n : ℕ) :
    ∑ k ∈ Finset.Icc 1 n, ((⌊k * x⌋:ℝ)/k) ≤ ⌊n * x⌋ := by sorry
