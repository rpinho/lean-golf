import Mathlib
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

namespace Usa1996P1

theorem _root_.LeanGolf.compfiles.usa1996_p1 :
    (1 / (90:ℝ)) * ∑ n ∈ Finset.range 90, (2 * (n+1)) * Real.sin ((2 * (n+1)) * Real.pi / 180)
    = 1 / Real.tan (Real.pi / 180) := by sorry
