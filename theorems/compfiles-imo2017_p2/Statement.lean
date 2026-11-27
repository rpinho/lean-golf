import Mathlib.Tactic

noncomputable section

namespace Imo2017P2

open Function

variable {R : Type*}

variable {F : Type*}

abbrev solution_set : Set (ℝ → ℝ) :=
  { fun _ ↦ 0, fun x ↦ x - 1, fun x ↦ 1 - x }

theorem _root_.LeanGolf.compfiles.imo2017_p2 (f : ℝ → ℝ) :
    f ∈ solution_set ↔ ∀ x y, f (f x * f y) + f (x + y) = f (x * y) := by sorry
