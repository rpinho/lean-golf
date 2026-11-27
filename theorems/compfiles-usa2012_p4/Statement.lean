import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Algebra.Ring.Divisibility.Basic
import Mathlib.Data.Int.NatAbs
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa2012P4

open Nat

def IsSolution (f : ℕ → ℕ) : Prop :=
  (∀ n, 0 < n → 0 < f n) ∧
    (∀ n, 0 < n → f (n !) = (f n)!) ∧
      ∀ (m n : ℕ), 0 < m → 0 < n → m ≠ n → (m : ℤ) - n ∣ (f m : ℤ) - f n

abbrev solution_set : Set (ℕ → ℕ) :=
  { f | (∀ n, 0 < n → f n = 1) ∨ (∀ n, 0 < n → f n = 2) ∨ (∀ n, 0 < n → f n = n) }

theorem _root_.LeanGolf.compfiles.usa2012_p4 (f : ℕ → ℕ) :
    f ∈ solution_set ↔ IsSolution f := by sorry
