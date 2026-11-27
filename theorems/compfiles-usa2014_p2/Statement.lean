import Mathlib.Tactic

noncomputable section

namespace Usa2014P2

def P (f : ℤ → ℤ) :=
    ∀ x y, x ≠ 0 → x * f (2 * f y - x) + y ^ 2 * f (2 * x - f y) = (f x ^ 2 : ℚ) / x + f (y * f y)

abbrev S : Set (ℤ → ℤ) := {0, fun x ↦ x ^ 2}

theorem _root_.LeanGolf.compfiles.usa2014_p2 {f : ℤ → ℤ} : P f ↔ f ∈ S := by sorry
