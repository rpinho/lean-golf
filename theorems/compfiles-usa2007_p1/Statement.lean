import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.Group.Nat
import Mathlib.Order.Lattice.Nat
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Ring.Basic

noncomputable section

namespace Usa2007P1

def s (n : ℕ) : ℕ → ℕ
  | 0 => n
  | (k + 1) => s n k + (k + 2 - s n k % (k + 2)) % (k + 2)

def a (n : ℕ) : ℕ → ℕ
  | 0 => n
  | (k + 1) => s n (k + 1) - s n k

theorem _root_.LeanGolf.compfiles.usa2007_p1 (n : ℕ) (_hn : 0 < n) :
    ∃ c N, ∀ k ≥ N, a n k = c := by sorry
