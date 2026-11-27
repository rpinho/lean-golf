import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Perm
import Mathlib.Dynamics.FixedPoints.Basic

noncomputable section

namespace Imo1987P1

def fiber (α : Type*) [Fintype α] [DecidableEq α] (k : ℕ) : Set (Equiv.Perm α) :=
  {σ : Equiv.Perm α | Fintype.card (Function.fixedPoints σ) = k}

instance {k : ℕ} (α : Type*) [Fintype α] [DecidableEq α] :
  Fintype (fiber α k) := by unfold fiber; infer_instance

def p (α : Type*) [Fintype α] [DecidableEq α] (k : ℕ) : ℕ := Fintype.card (fiber α k)

open scoped Nat

theorem _root_.LeanGolf.compfiles.imo1987_p1 {n : ℕ} (hn : 1 ≤ n) :
    ∑ k ∈ Finset.range (n + 1), k * p (Fin n) k = n ! := by sorry
