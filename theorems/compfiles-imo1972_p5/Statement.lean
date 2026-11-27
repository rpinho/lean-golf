import Mathlib
import Mathlib.Analysis.Normed.Module.Basic

namespace Imo1972P5

theorem _root_.LeanGolf.compfiles.imo1972_p5 (f g : ℝ → ℝ) (hf1 : ∀ x, ∀ y, f (x + y) + f (x - y) = 2 * f x * g y)
    (hf2 : BddAbove (Set.range fun x => ‖f x‖)) (hf3 : ∃ x, f x ≠ 0) (y : ℝ) : ‖g y‖ ≤ 1 := by sorry
