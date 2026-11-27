import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.NormNum.Prime

noncomputable section

namespace Usa1986P1

abbrev does_exist_14 : Bool := false

theorem _root_.LeanGolf.compfiles.usa1986_p1a :
    if does_exist_14 then
      ∃ n : ℕ, 0 < n ∧
        ∀ i ∈ Finset.range 14, ∃ p : ℕ, p.Prime ∧ p < 13 ∧ p ∣ n + i
    else
      ¬ ∃ n : ℕ, 0 < n ∧
        ∀ i ∈ Finset.range 14, ∃ p : ℕ, p.Prime ∧ p < 13 ∧ p ∣ n + i := by sorry
