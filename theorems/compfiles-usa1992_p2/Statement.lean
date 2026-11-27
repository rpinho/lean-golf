import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Tactic

namespace Usa1992P2

open Real

theorem _root_.LeanGolf.compfiles.usa1992_p2 :
  ∑ i ∈ Finset.range 89, 1 / cos (i * π / 180) / cos ((i + 1) * π / 180) =
  cos (π / 180) / sin (π / 180) ^ 2 := by sorry
