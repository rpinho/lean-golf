import Mathlib.Tactic

noncomputable section

namespace Imo2019P1

abbrev solution_set : Set (ℤ → ℤ) :=
  { f | (∀ z, f z = 0) ∨ ∃ c, ∀ z, f z = 2 * z + c }

theorem _root_.LeanGolf.compfiles.imo2019_p1 (f : ℤ → ℤ) :
    (∀ a b, f (2 * a) + 2 * (f b) = f (f (a + b))) ↔ f ∈ solution_set := by sorry
