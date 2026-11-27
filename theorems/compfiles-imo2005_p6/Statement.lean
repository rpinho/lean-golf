import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Combinatorics.Enumerative.DoubleCounting
import Mathlib
import Mathlib.Data.Int.ModEq
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace Imo2005P6

open Finset

theorem _root_.LeanGolf.compfiles.imo2005_p6 {n : ℕ} (s : Fin n → Finset (Fin 6))
    (pair : ∀ p q : Fin 6, p ≠ q →
      2 * n < 5 * (Finset.univ.filter fun i => p ∈ s i ∧ q ∈ s i).card)
    (hall : ∀ i, (s i).card < 6) :
    ∃ i j, i ≠ j ∧ (s i).card = 5 ∧ (s j).card = 5 := by sorry
