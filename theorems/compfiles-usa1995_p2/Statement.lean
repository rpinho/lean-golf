import Mathlib.Analysis.SpecialFunctions.Trigonometric.Arctan

noncomputable section

namespace Usa1995P2

inductive TrigMap where
  | sin | cos | tan | arcsin | arccos | arctan

noncomputable def TrigMap.apply : TrigMap → ℝ → ℝ
  | .sin => Real.sin
  | .cos => Real.cos
  | .tan => Real.tan
  | .arcsin => Real.arcsin
  | .arccos => Real.arccos
  | .arctan => Real.arctan

noncomputable def run (l : List TrigMap) (x : ℝ) : ℝ := l.foldl (fun a f => f.apply a) x

theorem _root_.LeanGolf.compfiles.usa1995_p2 (x : ℚ) (hx : 0 < x) :
    ∃ l : List TrigMap, run l 0 = (x : ℝ) := by sorry
