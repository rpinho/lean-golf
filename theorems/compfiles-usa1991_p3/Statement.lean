import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.FieldTheory.Finite.Basic

noncomputable section

namespace Usa1991P3

def f : ℕ → ℕ
  | 0 => 2
  | n + 1 => 2 ^ f n

theorem _root_.LeanGolf.compfiles.usa1991_p3 (m : ℕ) (hm : 1 ≤ m) :
    ∃ N : ℕ, ∀ n : ℕ, N ≤ n → f n ≡ f N [MOD m] := by sorry
