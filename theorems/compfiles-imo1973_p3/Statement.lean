import Mathlib.Tactic

noncomputable section

namespace Imo1973P3

noncomputable abbrev solution : ℝ := (4:ℝ)/5

theorem _root_.LeanGolf.compfiles.imo1973_p3
    (S : Set (ℝ × ℝ))
    (hS : S = {(a, b) | ∃ x : ℝ, x ^ 4 + a * x ^ 3 + b * x ^ 2 + a * x + 1 = 0}) :
    IsLeast { x.1 ^ 2 + x.2 ^ 2 | x ∈ S } solution := by sorry
