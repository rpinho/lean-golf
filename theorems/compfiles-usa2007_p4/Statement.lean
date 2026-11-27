import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected
import Mathlib
import Mathlib.Data.Int.Interval
import Mathlib.Order.ConditionallyCompleteLattice.Basic
import Mathlib.Tactic.NormNum.Ineq
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Ring.Basic

noncomputable section

namespace Usa2007P4

def gridAdj (a b : ℤ × ℤ) : Prop := (a.1 - b.1).natAbs + (a.2 - b.2).natAbs = 1

def gridGraph : SimpleGraph (ℤ × ℤ) where
  Adj := gridAdj
  symm := ⟨fun a b h => by
    have e1 : b.1 - a.1 = -(a.1 - b.1) := by ring
    have e2 : b.2 - a.2 = -(a.2 - b.2) := by ring
    show (b.1 - a.1).natAbs + (b.2 - a.2).natAbs = 1
    rw [e1, e2, Int.natAbs_neg, Int.natAbs_neg]
    exact h⟩
  loopless := ⟨fun a h => by simp [gridAdj] at h⟩

structure IsAnimal (s : Finset (ℤ × ℤ)) : Prop where
  nonempty : s.Nonempty
  preconnected : (gridGraph.induce (s : Set (ℤ × ℤ))).Preconnected

def IsDinosaur (s : Finset (ℤ × ℤ)) : Prop := IsAnimal s ∧ 2007 ≤ s.card

def IsDinoPartition (d : Finset (ℤ × ℤ)) (parts : Finset (Finset (ℤ × ℤ))) : Prop :=
  2 ≤ parts.card ∧
  (∀ p ∈ parts, IsDinosaur p) ∧
  (∀ p ∈ parts, ∀ q ∈ parts, p ≠ q → Disjoint p q) ∧
  parts.biUnion id = d

def IsPrimitive (d : Finset (ℤ × ℤ)) : Prop :=
  IsDinosaur d ∧ ¬ ∃ parts, IsDinoPartition d parts

abbrev answer : ℕ := 8025

theorem _root_.LeanGolf.compfiles.usa2007_p4 :
    IsGreatest {n : ℕ | ∃ d : Finset (ℤ × ℤ), IsPrimitive d ∧ d.card = n} answer := by sorry
