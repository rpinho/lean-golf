import Mathlib.Algebra.CharP.Defs
import Mathlib.Algebra.Order.Archimedean.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Finset.Max
import Mathlib.Data.Set.Finite.Lattice
import Mathlib.Order.ConditionallyCompleteLattice.Indexed

noncomputable section

namespace Imo2000P3

open Finset

def Move (lam : ℝ) {n : ℕ} (x y : Fin n → ℝ) : Prop :=
  ∃ i j, x i < x j ∧ y = Function.update x i (x j + lam * (x j - x i))

def Reachable (lam : ℝ) {n : ℕ} (x y : Fin n → ℝ) : Prop :=
  Relation.ReflTransGen (Move lam) x y

def AllRightOf {n : ℕ} (lam : ℝ) : Prop :=
  ∀ x : Fin n → ℝ, (∃ i j, x i ≠ x j) → ∀ M : ℝ,
    ∃ y : Fin n → ℝ, Reachable lam x y ∧ ∀ i, M < y i

noncomputable abbrev solution_set (n : ℕ) : Set ℝ := Set.Ici (1 / ((n : ℝ) - 1))

theorem _root_.LeanGolf.compfiles.imo2000_p3 (n : ℕ) (hn : 2 ≤ n) (lam : ℝ) :
    lam ∈ solution_set n ↔ (0 < lam ∧ AllRightOf (n := n) lam) := by sorry
