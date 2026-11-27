import Mathlib.Tactic

noncomputable section

namespace Usa2013P4

open Real

def Distinguished (x y z : ℝ) : Prop :=
  (y - 1) * (z - 1) = 1 ∧ (x - 1) * (√(y - 1) + √(z - 1)) ^ 2 = 1

abbrev solution_set : Set (ℝ × ℝ × ℝ) :=
  { p : ℝ × ℝ × ℝ |
      Distinguished p.1 p.2.1 p.2.2 ∨ Distinguished p.2.1 p.1 p.2.2 ∨
        Distinguished p.2.2 p.1 p.2.1 }

theorem _root_.LeanGolf.compfiles.usa2013_p4 (x y z : ℝ) :
    1 ≤ x ∧ 1 ≤ y ∧ 1 ≤ z ∧
      min (min (√(x + x * y * z)) (√(y + x * y * z))) (√(z + x * y * z)) =
        √(x - 1) + √(y - 1) + √(z - 1) ↔ (x, y, z) ∈ solution_set := by sorry
