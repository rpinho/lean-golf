import Mathlib

noncomputable section

namespace Imo2020P4

structure Car (n : ℕ) : Type where
  /-- The starting point. -/
  start : Fin (n ^ 2)
  /-- The finishing point. -/
  finish : Fin (n ^ 2)
  start_lt_finish : start < finish

structure Company (n k : ℕ) : Type where
  /-- The individual cars. -/
  cars : Fin k → Car n
  injective_start : Function.Injective fun i ↦ (cars i).start
  injective_finish : Function.Injective fun i ↦ (cars i).finish
  monovary_start_finish : Monovary (fun i ↦ (cars i).start) (fun i ↦ (cars i).finish)

structure Company.linkage {n k : ℕ} (c : Company n k) : Type where
  /-- The sequence of cars used. -/
  cars : List (Fin k)
  nonempty : cars ≠ []
  valid : cars.IsChain fun i j ↦ (c.cars i).finish = (c.cars j).start

def Company.linkage.start {n k : ℕ} {c : Company n k} (x : c.linkage) : Fin (n ^ 2) :=
  (c.cars (x.cars.head x.nonempty)).start

def Company.linkage.finish {n k : ℕ} {c : Company n k} (x : c.linkage) : Fin (n ^ 2) :=
  (c.cars (x.cars.getLast x.nonempty)).finish

def Company.linked {n k : ℕ} (c : Company n k) (l h : Fin (n ^ 2)) : Prop :=
  ∃ x : c.linkage, x.start = l ∧ x.finish = h

universe u

noncomputable instance instFintypeEdgeSetOfFinite {V : Type*} [Finite V] (G : SimpleGraph V) :
    Fintype G.edgeSet := Fintype.ofFinite _

abbrev answer : (Set.Ioi 1) → ℕ := fun n ↦ n * n - n + 1

theorem _root_.LeanGolf.compfiles.imo2020_p4 (n : Set.Ioi 1) :
    IsLeast
      {k : ℕ | ∀ A B : Company n k, ∃ i j, A.linked i j ∧ B.linked i j}
      (answer n) := by sorry
