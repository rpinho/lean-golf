import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Finset.Max
import Mathlib.Data.Nat.Log
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.NormNum.Ineq
import Mathlib.Tactic.Ring

noncomputable section

namespace Imo2023P5

structure JapaneseTriangle (n : ℕ) where
  red : (i : Finset.Icc 1 n) → Fin i.val

def next_row {n} (i : Finset.Icc 1 n) (h : i.val + 1 ≤ n) : Finset.Icc 1 n :=
  ⟨i.val + 1, by aesop⟩

structure NinjaPath (n : ℕ) where
  steps : (i : Finset.Icc 1 n) → Fin i.val
  steps_valid : ∀ i : Finset.Icc 1 n, (h : i.val + 1 ≤ n) →
     ((steps i).val = steps (next_row i h) ∨
      (steps i).val + 1 = steps (next_row i h))

abbrev solution_value (n : ℕ) : ℕ := Nat.clog 2 (n + 1)

variable {n : ℕ}

theorem _root_.LeanGolf.compfiles.imo2023_p5 (n : ℕ) :
    IsGreatest {k | ∀ j : JapaneseTriangle n,
                    ∃ p : NinjaPath n,
                      k ≤ Fintype.card {i // j.red i = p.steps i}}
               (solution_value n) := by sorry
