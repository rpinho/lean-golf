import Mathlib.Tactic
import Mathlib.Algebra.Order.Group.Int.Sum

noncomputable section

def Condition (a : ℕ → ℤ) : Prop :=
  (∀ i, a i ∈ Finset.Icc 1 2015) ∧ Function.Injective fun i ↦ i + a i

variable {a : ℕ → ℤ} (ha : Condition a) {t : ℕ}

namespace Imo2015P6

theorem _root_.LeanGolf.compfiles.imo2015_p6 (ha : Condition a) :
    ∃ b > 0, ∃ N, ∀ m ≥ N, ∀ n > m, |∑ j ∈ Finset.Ico m n, (a j - b)| ≤ 1007 ^ 2 := by sorry
