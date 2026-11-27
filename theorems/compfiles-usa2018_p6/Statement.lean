import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib
import Mathlib.GroupTheory.Perm.Fin
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Linarith.Lemmas

noncomputable section

namespace Usa2018P6

open Equiv Finset Function

def ratio {n : ℕ} (σ : Equiv.Perm (Fin n)) (k : Fin n) : ℚ :=
  ((σ k).val + 1) / (k.val + 1)

def Valid {n : ℕ} (σ : Equiv.Perm (Fin n)) : Prop :=
  Function.Injective (ratio σ)

instance {n : ℕ} : DecidablePred (Valid (n := n)) := fun σ => by
  unfold Valid Function.Injective
  infer_instance

def nums {n : ℕ} (σ : Equiv.Perm (Fin n)) : Finset (Fin n) :=
  Finset.univ.filter fun k => k.val < (σ k).val

def label {n : ℕ} (σ : Equiv.Perm (Fin n)) (k : Fin n) : ℚ :=
  (k.val + 1) / ((σ k).val + 1)

def Fantastic {n : ℕ} (σ : Equiv.Perm (Fin n)) : Prop :=
  Set.InjOn (label σ) (nums σ)

instance {n : ℕ} (σ : Equiv.Perm (Fin n)) : Decidable (Fantastic σ) := by
  unfold Fantastic Set.InjOn
  infer_instance

def IsVertex {n : ℕ} (σ : Equiv.Perm (Fin n)) : Prop :=
  Function.Involutive σ ∧ (Finset.univ.filter fun x => σ x = x).card ≤ 1

instance {n : ℕ} : DecidablePred (IsVertex (n := n)) := fun σ => by
  unfold IsVertex Function.Involutive
  infer_instance

def IsSwitch {n : ℕ} (σ φ : Equiv.Perm (Fin n)) : Prop :=
  Function.Involutive φ ∧ (∀ x, x ∉ nums σ → φ x = x) ∧
    ∀ x, x ∈ nums σ → label σ (φ x) = label σ x

instance {n : ℕ} (σ : Equiv.Perm (Fin n)) : DecidablePred (IsSwitch σ) := fun φ => by
  unfold IsSwitch Function.Involutive
  infer_instance

def WPairs (n : ℕ) : Type :=
  {p : Equiv.Perm (Fin n) × Equiv.Perm (Fin n) // IsVertex p.1 ∧ IsSwitch p.1 p.2}

instance {n : ℕ} : Fintype (WPairs n) := by
  unfold WPairs
  infer_instance

theorem _root_.LeanGolf.compfiles.usa2018_p6 (n : ℕ) (_hn : 1 ≤ n) :
    Odd (Fintype.card {σ : Equiv.Perm (Fin n) // Valid σ}) := by sorry
