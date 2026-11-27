import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.NormNum.Ineq
import Mathlib.Tactic.Positivity.Core
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa1978P3

def Expressible (n : ℕ) : Prop :=
  ∃ l : List ℕ, (∀ a ∈ l, 0 < a) ∧ l.sum = n ∧ (l.map fun a : ℕ => (a : ℚ)⁻¹).sum = 1

theorem _root_.LeanGolf.compfiles.usa1978_p3 (h : ∀ n, 33 ≤ n → n ≤ 73 → Expressible n) :
    ∀ n, 73 < n → Expressible n := by sorry
