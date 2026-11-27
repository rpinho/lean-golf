import Mathlib.Tactic

noncomputable section

namespace Imo2015P5

abbrev SolutionSet : Set (ℝ → ℝ) := { fun x ↦ x, fun x ↦ 2 - x }

theorem _root_.LeanGolf.compfiles.imo2015_p5 (f : ℝ → ℝ) :
    f ∈ SolutionSet ↔
    ∀ x y, f (x + f (x + y)) + f (x * y) = x + f (x + y) + y * f x := by sorry
