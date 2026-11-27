import Mathlib
import Mathlib.Algebra.Order.Positive.Field
import Mathlib.Tactic

noncomputable section

namespace Usa2022P3

abbrev PosReal : Type := { x : ℝ // 0 < x }

notation "ℝ+" => PosReal

abbrev solution_set : Set (ℝ+ → ℝ+) :=
  { f : ℝ+ → ℝ+ | ∃ c : ℝ+, f = fun x ↦ c / x }

theorem _root_.LeanGolf.compfiles.usa2022_p3 (f : ℝ+ → ℝ+) :
  f ∈ solution_set ↔
    (∀ x y : ℝ+, f x = f (f (f x) + y) + f (x * f y) * f (x + y)) := by sorry
