import Mathlib.Tactic
import Mathlib.Algebra.GroupWithZero.Basic

noncomputable section

namespace Imo1972P4

abbrev solution_set : Set (ℝ × ℝ × ℝ × ℝ × ℝ) :=
  {(a, b, c, d, e) | a = b ∧ b = c ∧ c = d ∧ d = e}

theorem _root_.LeanGolf.compfiles.imo1972_p4 (a b c d e : ℝ)
  (h₀ : 0 < a ∧ 0 < b ∧ 0 < c ∧ 0 < d ∧ 0 < e):
    (a^2 - c * e) * (b^2 - c * e) ≤ 0 ∧
    (b^2 - d * a) * (c^2 - d * a) ≤ 0 ∧
    (c^2 - e * b) * (d^2 - e * b) ≤ 0 ∧
    (d^2 - a * c) * (e^2 - a * c) ≤ 0 ∧
    (e^2 - b * d) * (a^2 - b * d) ≤ 0 ↔
      (a, b, c, d, e) ∈ solution_set := by sorry
