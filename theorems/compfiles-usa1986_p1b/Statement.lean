import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.NormNum.Prime

noncomputable section

namespace Usa1986P1

abbrev does_exist_21 : Bool := true

theorem _root_.LeanGolf.compfiles.usa1986_p1b :
    if does_exist_21 then
      ∃ n : ℕ, 0 < n ∧
        ∀ i ∈ Finset.range 21, ∃ p : ℕ, p.Prime ∧ p < 17 ∧ p ∣ n + i
    else
      ¬ ∃ n : ℕ, 0 < n ∧
        ∀ i ∈ Finset.range 21, ∃ p : ℕ, p.Prime ∧ p < 17 ∧ p ∣ n + i := by sorry
