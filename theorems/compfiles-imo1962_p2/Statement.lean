import Mathlib.Tactic

noncomputable section

namespace Imo1962P2

noncomputable abbrev SolutionSet : Set ℝ := Set.Ico (-1) (1 - √31 / 8)

theorem _root_.LeanGolf.compfiles.imo1962_p2 (x : ℝ) :
    x ∈ SolutionSet ↔
    x ≤ 3 ∧ -1 ≤ x ∧ 1/2 < √(3 - x) - √(x + 1) := by sorry
