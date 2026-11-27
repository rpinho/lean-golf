import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa2017P6

noncomputable def f (x : Fin 4 → ℝ) : ℝ :=
  ∑ i, x i / (x (i + 1) ^ 3 + 4)

def Conditions (x : Fin 4 → ℝ) : Prop :=
  0 ≤ x ∧ ∑ i, x i = 4

noncomputable abbrev solution : ℝ := 2 / 3

theorem _root_.LeanGolf.compfiles.usa2017_p6 : IsLeast (f '' {x | Conditions x}) solution := by sorry
