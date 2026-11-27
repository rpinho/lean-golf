import Mathlib.Algebra.AffineMonoid.Basic
import Mathlib.Algebra.Polynomial.Coeff
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Analysis.Normed.Ring.Lemmas
import Mathlib.GroupTheory.Perm.Fin

noncomputable section

namespace Usa2017P2

open Finset Polynomial Equiv

def invPair (c x y : ℤ) : Prop := (x ≤ c ∧ y < x) ∨ (c < y ∧ x ≤ c) ∨ (y < x ∧ c < y)

instance (c x y : ℤ) : Decidable (invPair c x y) := by
  unfold invPair; infer_instance

def ainvCount {n : ℕ} (m : Fin n → ℤ) (A : Fin n → ℤ) (σ : Perm (Fin n)) : ℕ :=
  ∑ i : Fin n, ∑ j : Fin n, if i < j ∧ invPair (A i) (m (σ i)) (m (σ j)) then 1 else 0

theorem _root_.LeanGolf.compfiles.usa2017_p2 {n : ℕ} (m : Fin n → ℕ) (_hm : ∀ i, 0 < m i) (A B : Fin n → ℤ) (k : ℕ) :
    (univ.filter (fun σ : Perm (Fin n) => ainvCount (fun i => (m i : ℤ)) A σ = k)).card =
    (univ.filter (fun σ : Perm (Fin n) => ainvCount (fun i => (m i : ℤ)) B σ = k)).card := by sorry
