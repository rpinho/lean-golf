import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Data.Nat.Factorial.BigOperators
import Mathlib.Data.Set.Card

noncomputable section

open scoped Nat

namespace Usa2019P4

abbrev answer (n : ℕ) : ℕ := (2 * n)! * 2 ^ (n ^ 2)

theorem _root_.LeanGolf.compfiles.usa2019_p4 (n : ℕ) :
    Nat.card {S : Fin (n + 1) → Fin (n + 1) → Finset (Fin (2 * n)) //
      (∀ i j, (S i j).card = i.val + j.val) ∧
      (∀ i k j l, i ≤ k → j ≤ l → S i j ⊆ S k l)} = answer n := by sorry
