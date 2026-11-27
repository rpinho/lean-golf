import Mathlib.Tactic
import Mathlib.Data.Fin.Tuple.Sort

noncomputable section

namespace Imo1971P1

def E {n : ℕ} (a : Fin n → ℝ) : ℝ :=
  ∑ i, ∏ j ≠ i, (a i - a j)

def P (n : ℕ) : Prop :=
  ∀ (a : Fin n → ℝ), E a ≥ 0

theorem _root_.LeanGolf.compfiles.imo1971_p1 : P 3 ∧ P 5 ∧ ∀ n > 2, n ≠ 3 ∧ n ≠ 5 → ¬P n := by sorry
