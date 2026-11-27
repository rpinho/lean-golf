import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Analysis.Normed.Ring.Lemmas
import Mathlib
import Mathlib.RingTheory.Coprime.Lemmas
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.LinearCombination.Lemmas

noncomputable section

namespace Usa2020P4

def det (P Q : ℕ × ℕ) : ℤ := (P.1 : ℤ) * (Q.2 : ℤ) - (Q.1 : ℤ) * (P.2 : ℤ)

abbrev answer : ℕ := 197

theorem _root_.LeanGolf.compfiles.usa2020_p4 :
    IsGreatest {N : ℕ | ∃ v : Fin 100 → ℕ × ℕ, Function.Injective v ∧
      N = (Finset.univ.filter fun p : Fin 100 × Fin 100 =>
        p.1 < p.2 ∧ |det (v p.1) (v p.2)| = 1).card} answer := by sorry
