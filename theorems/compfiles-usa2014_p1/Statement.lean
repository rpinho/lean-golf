import Mathlib.Tactic

noncomputable section

namespace Usa2014P1

open Polynomial

noncomputable def Objective (x : Fin 4 → ℝ) : ℝ := ∏ i, ((x i)^2 + 1)

def Conditions (x : Fin 4 → ℝ) : Prop := ∃ a b c d : ℝ, (5 ≤ b - d) ∧
    ((X - C (x 0)) * (X - C (x 1)) * (X - C (x 2)) * (X - C (x 3))
    = X^4 + C a * X^3 + C b * X^2 + C c * X + C d)

noncomputable abbrev solution : ℝ := 16

theorem _root_.LeanGolf.compfiles.usa2014_p1 : IsLeast (Objective '' { x | Conditions x }) solution := by sorry
