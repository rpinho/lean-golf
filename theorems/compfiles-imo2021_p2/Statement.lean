import Mathlib

namespace Imo2021P2

universe u

theorem _root_.LeanGolf.compfiles.imo2021_p2 (n : ℕ) (x : Fin n → ℝ) :
    ∑ i, ∑ j, √|x i - x j| ≤ ∑ i, ∑ j, √|x i + x j| := by sorry
