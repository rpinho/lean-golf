import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Ring.Basic

noncomputable section

namespace Usa2000P4

def Good {m n : ℕ} (S : Finset (Fin m × Fin n)) : Prop :=
  ∀ x ∈ S, ∀ y ∈ S, ∀ z ∈ S, x ≠ y → y ≠ z → x ≠ z →
    ¬((x.1 = y.1 ∨ x.1 = z.1 ∨ y.1 = z.1) ∧ (x.2 = y.2 ∨ x.2 = z.2 ∨ y.2 = z.2))

abbrev smallestN : ℕ := 1999

theorem _root_.LeanGolf.compfiles.usa2000_p4 :
    IsLeast {n : ℕ | ∀ S : Finset (Fin 1000 × Fin 1000), S.card = n → ¬Good S}
      smallestN := by sorry
