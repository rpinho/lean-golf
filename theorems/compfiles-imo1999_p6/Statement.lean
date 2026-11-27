import Mathlib.Tactic

noncomputable section

namespace Imo1999P6

noncomputable abbrev SolutionSet : Set (ℝ → ℝ) := { fun x ↦ 1 - x^2 / 2 }

theorem _root_.LeanGolf.compfiles.imo1999_p6 (f : ℝ → ℝ) :
    f ∈ SolutionSet ↔
    ∀ x y, f (x - f y) = f (f y) + x * f y + f x - 1 := by sorry
