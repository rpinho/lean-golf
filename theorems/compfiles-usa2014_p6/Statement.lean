import Mathlib.Algebra.BigOperators.Associated
import Mathlib.Algebra.CharP.Defs
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Algebra.Order.Star.Real
import Mathlib.Data.Nat.Cast.Order.Field
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.Log
import Mathlib
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity.Basic
import Mathlib.Tactic.Ring

namespace Usa2014P6

open Finset

theorem _root_.LeanGolf.compfiles.usa2014_p6 :
    ∃ c : ℝ, 0 < c ∧
      ∀ a b n : ℕ, 0 < a → 0 < b → 0 < n →
        (∀ i ∈ range (n + 1), ∀ j ∈ range (n + 1), 1 < Nat.gcd (a + i) (b + j)) →
        (c * (n : ℝ)) ^ n < ((min a b : ℕ) : ℝ) := by sorry
