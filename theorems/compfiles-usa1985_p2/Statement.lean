import Mathlib.Algebra.Order.Star.Real
import Mathlib.Analysis.Normed.Order.Lattice
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa1985P2

abbrev answer : ℝ × ℝ := (99999.9984, 100000.0016)

theorem _root_.LeanGolf.compfiles.usa1985_p2 (N : ℝ) (hN : N = 10 ^ 10) :
    ∃ x₁ x₂ : ℝ, x₁ < x₂ ∧
      (∀ x : ℝ, x ^ 4 - (2 * N + 1) * x ^ 2 - x + N ^ 2 + N - 1 = 0 ↔
        x = x₁ ∨ x = x₂) ∧
      |x₁ - answer.1| < 0.00005 ∧ |x₂ - answer.2| < 0.00005 := by sorry
