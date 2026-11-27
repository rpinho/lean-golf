import Mathlib.Tactic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

noncomputable section

namespace Imo1963P1

noncomputable abbrev f (p : ℝ) : Set ℝ :=
  if 0 ≤ p ∧ p ≤ (4 : ℝ) / 3
  then { (4 - p) / (2 * Real.sqrt (4 - 2 * p)) }
  else ∅

theorem _root_.LeanGolf.compfiles.imo1963_p1 : ∀ (p x : ℝ), (x ^ 2 - p) ≥ 0 → (x ^ 2 - 1) ≥ 0 →
  (Real.sqrt (x ^ 2 - p) + 2 * Real.sqrt (x ^ 2 - 1) = x ↔ (x ∈ f p)) := by sorry
