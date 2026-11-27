import Mathlib.Tactic
import Mathlib.Analysis.MeanInequalitiesPow

namespace Usa1983P2

open Polynomial

theorem _root_.LeanGolf.compfiles.usa1983_p2 (a b c d e : ℝ) (x : Fin 5 → ℝ):
    2*a^2 < 5*b → ¬(((X - C (x 0)) * (X - C (x 1)) * (X - C (x 2)) * (X - C (x 3)) * (X - C (x 4))
    = X^5 + C a * X^4 + C b * X^3 + C c * X^2 + C d * X + C e)) := by sorry
