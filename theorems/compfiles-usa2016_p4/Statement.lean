import Mathlib.Tactic
import Mathlib.Analysis.SpecialFunctions.Log.Base

noncomputable section

namespace Usa2016P4

def f_good (f : ℝ → ℝ) : Prop :=  ∀ x y, (f x + x*y) * f (x - 3*y) + (f y + x * y) * f (3*x - y) = (f (x+y))^2

abbrev solution_set : Set (ℝ → ℝ) := {fun t ↦ 0, fun t ↦ t^2}

theorem _root_.LeanGolf.compfiles.usa2016_p4 (f : ℝ → ℝ) : f ∈ solution_set ↔ f_good f := by sorry
