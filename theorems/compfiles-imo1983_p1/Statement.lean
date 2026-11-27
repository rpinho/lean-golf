import Mathlib.Algebra.Order.Positive.Field
import Mathlib.Tactic

noncomputable section

namespace Imo1983P1

abbrev PosReal : Type := { x : ℝ // 0 < x }

notation "ℝ+" => PosReal

noncomputable abbrev SolutionSet : Set (ℝ+ → ℝ+) := { fun x ↦ 1 / x }

theorem _root_.LeanGolf.compfiles.imo1983_p1 (f : ℝ+ → ℝ+) :
    f ∈ SolutionSet ↔
    ((∀ x y, f (x * f y) = y * f x) ∧
     (∀ ε, ∃ x, ∀ y, x < y → f y < ε)) := by sorry
