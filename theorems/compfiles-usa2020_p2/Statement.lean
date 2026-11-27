import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.Order.ConditionallyCompleteLattice.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Linarith.Lemmas
import Mathlib.Tactic.NormNum.Ineq
import Mathlib.Tactic.Ring.Basic
import Mathlib.Tactic.Zify

noncomputable section

namespace Usa2020P2

inductive Beam (n : ℕ)
  | xBeam (j k : Fin n)
  | yBeam (i k : Fin n)
  | zBeam (i j : Fin n)
  deriving DecidableEq

variable {n : ℕ}

namespace Beam

def covers : Beam n → Fin n → Fin n → Fin n → Prop
  | xBeam j k => fun _ y z => y = j ∧ z = k
  | yBeam i k => fun x _ z => x = i ∧ z = k
  | zBeam i j => fun x y _ => x = i ∧ y = j

end Beam

open Beam

def DisjointBeams (S : Finset (Beam n)) : Prop :=
  ∀ b₁ ∈ S, ∀ b₂ ∈ S, (∃ x y z, b₁.covers x y z ∧ b₂.covers x y z) → b₁ = b₂

def xSupp {n : ℕ} (S : Finset (Beam n)) (j k : Fin n) : Prop :=
  (j.val = 0 ∨ (∃ j' : Fin n, j'.val + 1 = j.val ∧ xBeam j' k ∈ S) ∨
      (∃ i' j' : Fin n, j'.val + 1 = j.val ∧ zBeam i' j' ∈ S)) ∧
    (j.val + 1 = n ∨ (∃ j' : Fin n, j'.val = j.val + 1 ∧ xBeam j' k ∈ S) ∨
      (∃ i' j' : Fin n, j'.val = j.val + 1 ∧ zBeam i' j' ∈ S)) ∧
    (k.val = 0 ∨ (∃ k' : Fin n, k'.val + 1 = k.val ∧ xBeam j k' ∈ S) ∨
      (∃ i' k' : Fin n, k'.val + 1 = k.val ∧ yBeam i' k' ∈ S)) ∧
    (k.val + 1 = n ∨ (∃ k' : Fin n, k'.val = k.val + 1 ∧ xBeam j k' ∈ S) ∨
      (∃ i' k' : Fin n, k'.val = k.val + 1 ∧ yBeam i' k' ∈ S))

def ySupp {n : ℕ} (S : Finset (Beam n)) (i k : Fin n) : Prop :=
  (i.val = 0 ∨ (∃ i' : Fin n, i'.val + 1 = i.val ∧ yBeam i' k ∈ S) ∨
      (∃ i' j' : Fin n, i'.val + 1 = i.val ∧ zBeam i' j' ∈ S)) ∧
    (i.val + 1 = n ∨ (∃ i' : Fin n, i'.val = i.val + 1 ∧ yBeam i' k ∈ S) ∨
      (∃ i' j' : Fin n, i'.val = i.val + 1 ∧ zBeam i' j' ∈ S)) ∧
    (k.val = 0 ∨ (∃ k' : Fin n, k'.val + 1 = k.val ∧ yBeam i k' ∈ S) ∨
      (∃ j' k' : Fin n, k'.val + 1 = k.val ∧ xBeam j' k' ∈ S)) ∧
    (k.val + 1 = n ∨ (∃ k' : Fin n, k'.val = k.val + 1 ∧ yBeam i k' ∈ S) ∨
      (∃ j' k' : Fin n, k'.val = k.val + 1 ∧ xBeam j' k' ∈ S))

def zSupp {n : ℕ} (S : Finset (Beam n)) (i j : Fin n) : Prop :=
  (i.val = 0 ∨ (∃ i' : Fin n, i'.val + 1 = i.val ∧ zBeam i' j ∈ S) ∨
      (∃ i' k' : Fin n, i'.val + 1 = i.val ∧ yBeam i' k' ∈ S)) ∧
    (i.val + 1 = n ∨ (∃ i' : Fin n, i'.val = i.val + 1 ∧ zBeam i' j ∈ S) ∨
      (∃ i' k' : Fin n, i'.val = i.val + 1 ∧ yBeam i' k' ∈ S)) ∧
    (j.val = 0 ∨ (∃ j' : Fin n, j'.val + 1 = j.val ∧ zBeam i j' ∈ S) ∨
      (∃ j' k' : Fin n, j'.val + 1 = j.val ∧ xBeam j' k' ∈ S)) ∧
    (j.val + 1 = n ∨ (∃ j' : Fin n, j'.val = j.val + 1 ∧ zBeam i j' ∈ S) ∨
      (∃ j' k' : Fin n, j'.val = j.val + 1 ∧ xBeam j' k' ∈ S))

def Supp (S : Finset (Beam n)) : Prop :=
  (∀ j k, xBeam j k ∈ S → xSupp S j k) ∧
    (∀ i k, yBeam i k ∈ S → ySupp S i k) ∧
    (∀ i j, zBeam i j ∈ S → zSupp S i j)

abbrev solution : ℕ := 3030

theorem _root_.LeanGolf.compfiles.usa2020_p2 :
    IsLeast {m | ∃ S : Finset (Beam 2020), S.Nonempty ∧ DisjointBeams S ∧ Supp S ∧
      S.card = m} solution := by sorry
