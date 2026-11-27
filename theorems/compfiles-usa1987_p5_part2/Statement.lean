import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.Chebyshev
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib
import Mathlib.Data.Nat.Choose.Cast
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa1987P5

variable {n : ℕ}

def numGoodTriples (a : Fin n → Bool) : ℕ :=
  (Finset.univ.filter fun t : Fin n × Fin n × Fin n ↦
    t.1 < t.2.1 ∧ t.2.1 < t.2.2 ∧
      ¬ ((a t.1 = false ∧ a t.2.1 = true ∧ a t.2.2 = false) ∨
         (a t.1 = true ∧ a t.2.1 = false ∧ a t.2.2 = true))).card

abbrev minT : ℕ → ℕ := fun n ↦ n * (n - 1) * (n - 3) / 8

theorem _root_.LeanGolf.compfiles.usa1987_p5_part2 (hn : Odd n) :
    IsLeast (Set.range fun a : Fin n → Bool ↦ numGoodTriples a) (minT n) := by sorry
