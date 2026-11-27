import Mathlib.Tactic

noncomputable section

namespace Imo2002P5

noncomputable abbrev SolutionSet : Set (ℝ → ℝ) :=
  { fun x ↦ 0, fun x ↦ 1/2, fun x ↦ x^2 }

theorem _root_.LeanGolf.compfiles.imo2002_p5 (f : ℝ → ℝ) :
    f ∈ SolutionSet ↔
    ∀ x y z t, (f x + f z) * (f y + f t) =
               f (x * y - z * t) + f (x * t + y * z) := by sorry
