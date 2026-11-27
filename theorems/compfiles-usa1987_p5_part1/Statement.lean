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

def eqBefore (a : Fin n → Bool) (i : Fin n) : Finset (Fin n) :=
  Finset.univ.filter fun j ↦ j < i ∧ a j = a i

def neqAfter (a : Fin n → Bool) (i : Fin n) : Finset (Fin n) :=
  Finset.univ.filter fun j ↦ i < j ∧ a j ≠ a i

def f (a : Fin n → Bool) (i : Fin n) : ℕ := (eqBefore a i).card + (neqAfter a i).card

def numGoodTriples (a : Fin n → Bool) : ℕ :=
  (Finset.univ.filter fun t : Fin n × Fin n × Fin n ↦
    t.1 < t.2.1 ∧ t.2.1 < t.2.2 ∧
      ¬ ((a t.1 = false ∧ a t.2.1 = true ∧ a t.2.2 = false) ∨
         (a t.1 = true ∧ a t.2.1 = false ∧ a t.2.2 = true))).card

theorem _root_.LeanGolf.compfiles.usa1987_p5_part1 (a : Fin n → Bool) :
    numGoodTriples a = ∑ i : Fin n, (f a i).choose 2 := by sorry
