import Mathlib
import Mathlib.Tactic.Linarith

namespace Imo2011P3

theorem _root_.LeanGolf.compfiles.imo2011_p3 (f : ℝ → ℝ) (hf : ∀ x y, f (x + y) ≤ y * f x + f (f x)) :
    ∀ x ≤ 0, f x = 0 := by sorry
