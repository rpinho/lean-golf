import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Finset.Powerset
import Mathlib.Order.Interval.Finset.Nat

namespace Usa1988P3

open Finset

theorem _root_.LeanGolf.compfiles.usa1988_p3 (f : Finset ℕ → ℕ) :
    ∃ Y : Finset ℕ, Y ⊆ Finset.Icc 1 20 ∧ Y.card = 10 ∧
      ∀ k ∈ Y, f (Y.erase k) ≠ k := by sorry
