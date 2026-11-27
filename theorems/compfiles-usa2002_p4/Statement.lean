import Mathlib.Tactic

noncomputable section

namespace Usa2002P4

def FE (f : ℝ → ℝ) : Prop :=
  ∀ x y, f (x^2 - y^2) = x * (f x) - y * (f y)

abbrev solution_set : Set (ℝ → ℝ) := { f | ∃ c : ℝ, ∀ x, f x = c * x }

theorem _root_.LeanGolf.compfiles.usa2002_p4 (f : ℝ → ℝ) :
    f ∈ solution_set ↔ FE f := by sorry
