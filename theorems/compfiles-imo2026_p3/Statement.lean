import Mathlib.Algebra.Field.ZMod
import Mathlib.Algebra.Order.Star.Real
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Data.List.GetD
import Mathlib.RingTheory.PicardGroup

noncomputable section

namespace Imo2026P3

noncomputable section

open scoped BigOperators

def pieceLengths (S : Finset ℝ) : List ℝ :=
  let l : List ℝ := (0 : ℝ) :: (S.sort (· ≤ ·)) ++ [1]
  List.zipWith (fun a b => b - a) l l.tail

def firstPlayerShare (L : List ℝ) : ℝ :=
  let sorted := L.mergeSort (· ≥ ·)
  ((sorted.zipIdx.filter (fun p => p.2 % 2 = 0)).map (fun p => p.1)).sum

def L (A B : Finset ℝ) : ℝ :=
  firstPlayerShare (pieceLengths (A ∪ B))

def AdmissibleMark (n : ℕ) (X : Finset ℝ) : Prop :=
  (↑X ⊆ Set.Ioo (0 : ℝ) 1) ∧ X.card ≤ n

def V (n : ℕ) : ℝ :=
  ⨆ A : {A : Finset ℝ // AdmissibleMark n A},
    ⨅ B : {B : Finset ℝ // AdmissibleMark n B ∧ Disjoint A.1 B}, L A.1 B.1

abbrev answer (n : ℕ) : ℝ := (2 : ℝ) ^ n / ((2 : ℝ) ^ (n + 1) - 1)

end

open scoped BigOperators

open scoped BigOperators

open scoped BigOperators

open scoped BigOperators

open Finset

open scoped BigOperators

open scoped BigOperators

open scoped BigOperators

variable {α β : Type*} {ι : Type*}

open scoped BigOperators List

open scoped BigOperators

open scoped BigOperators

open scoped BigOperators

open scoped BigOperators List

open scoped BigOperators List

open scoped BigOperators List

theorem _root_.LeanGolf.compfiles.imo2026_p3 (n : ℕ) (hn : 0 < n) : V n = answer n := by sorry
