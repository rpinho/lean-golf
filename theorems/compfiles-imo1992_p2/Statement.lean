import Mathlib.Tactic

noncomputable section

namespace Imo1992P2

abbrev solution_set : Set (ℝ → ℝ) := { fun x ↦ x }

theorem _root_.LeanGolf.compfiles.imo1992_p2 (f : ℝ → ℝ) :
    f ∈ solution_set ↔
    ∀ x y, f (x^2 + f y) = y + f x ^ 2 := by sorry
