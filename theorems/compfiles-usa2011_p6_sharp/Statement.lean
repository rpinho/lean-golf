import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib

namespace Usa2011P6

theorem _root_.LeanGolf.compfiles.usa2011_p6_sharp :
    ∃ A : Finset (Finset (Fin 11) ⊕ Fin 60),
      ∃ As : Fin 11 → Finset (Finset (Fin 11) ⊕ Fin 60),
        A.card = 225 ∧ (∀ i, As i ⊆ A) ∧ (∀ i, (As i).card = 45) ∧
        (∀ i j, i ≠ j → (As i ∩ As j).card = 9) ∧
        (Finset.univ.biUnion As).card = 165 := by sorry
