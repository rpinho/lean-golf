import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Data.Fin.VecNotation
import Mathlib.Data.Fintype.Powerset

noncomputable section

namespace Usa2016P1

open Finset

def HasChain (n : ℕ) : Prop :=
  ∃ X : Fin 100 → Finset (Fin n),
    (∀ i, (X i).Nonempty) ∧
      (∀ i j, X i = X j → i = j) ∧
        ∀ i : Fin 99, Disjoint (X i.castSucc) (X i.succ) ∧
          X i.castSucc ∪ X i.succ ≠ univ

abbrev solution_value : ℕ := 8

theorem _root_.LeanGolf.compfiles.usa2016_p1 : IsLeast {n | HasChain n} solution_value := by sorry
