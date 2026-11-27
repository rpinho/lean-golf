import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.Ring.Nat
import Mathlib.Data.Finset.Max
import Mathlib
import Mathlib.Tactic.Ring

namespace Imo2020P3

open scoped Finset

theorem _root_.LeanGolf.compfiles.imo2020_p3 {n : ℕ} {c : Fin (4 * n) → Fin n} (h : ∀ i, #{j | c j = i} = 4) :
    ∃ S : Finset (Fin (4 * n)), ∑ i ∈ S, ((i : ℕ) + 1) = ∑ i ∈ Sᶜ, ((i : ℕ) + 1) ∧
      ∀ i, #{j ∈ S | c j = i} = 2 := by sorry
