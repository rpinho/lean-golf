import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Data.Finset.Powerset
import Mathlib
import Mathlib.Tactic.Choose
import Mathlib.Tactic.NormNum

noncomputable section

namespace Usa1986P2

def Asleep (s e : Fin 5 → Fin 2 → ℝ) (p : Fin 5) (t : ℝ) : Prop :=
  ∃ k : Fin 2, s p k ≤ t ∧ t ≤ e p k

variable {s e : Fin 5 → Fin 2 → ℝ}

theorem _root_.LeanGolf.compfiles.usa1986_p2 (s e : Fin 5 → Fin 2 → ℝ)
    (hsleep : ∀ p q : Fin 5, p ≠ q → ∃ t, Asleep s e p t ∧ Asleep s e q t) :
    ∃ t : ℝ, ∃ p q r : Fin 5, p ≠ q ∧ p ≠ r ∧ q ≠ r ∧
      Asleep s e p t ∧ Asleep s e q t ∧ Asleep s e r t := by sorry
