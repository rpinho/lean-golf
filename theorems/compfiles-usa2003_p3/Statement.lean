import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Tactic.NormNum.Ineq

noncomputable section

namespace Usa2003P3

def t (a : ℕ → ℕ) : ℕ → ℕ :=
  fun i => ((Finset.range i).filter (fun j => a j ≠ a i)).card

theorem _root_.LeanGolf.compfiles.usa2003_p3 (n : ℕ) (hn : 0 < n) (a : ℕ → ℕ) (ha : ∀ i ≤ n, a i ≤ i) :
    ∃ k, k < n ∧ ∀ i ≤ n, t^[k] a i = t^[k+1] a i := by sorry
