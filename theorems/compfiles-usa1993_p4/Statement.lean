import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Tactic.NormNum.Ineq

noncomputable section

namespace Usa1993P4

abbrev constant_value (r s : ℕ) : ℕ := Nat.gcd r s

variable {r s : ℕ} (hr : Odd r) (hs : Odd s) {a : ℕ → ℕ}
    (ha0 : a 0 = r) (ha1 : a 1 = s)
    (han : ∀ n, a (n + 2) = ordCompl[2] (a (n + 1) + a n))

include hr hs ha0 ha1 han

omit hr hs ha0 ha1 han

theorem _root_.LeanGolf.compfiles.usa1993_p4 (r s : ℕ) (hr : Odd r) (hs : Odd s) (a : ℕ → ℕ)
    (ha0 : a 0 = r) (ha1 : a 1 = s)
    (han : ∀ n, a (n + 2) = ordCompl[2] (a (n + 1) + a n)) :
    ∃ N, ∀ n, N ≤ n → a n = constant_value r s := by sorry
