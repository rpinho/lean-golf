import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa2010P2

def Legal {n : ℕ} : (Fin n ≃ ZMod n) → List (ZMod n) → Prop
  | _, [] => True
  | e, p :: ps =>
      (e.symm p).val + 2 ≤ (e.symm (p + 1)).val ∧
      Legal (e.trans (Equiv.swap p (p + 1))) ps

def StateA {n : ℕ} (e : Fin n ≃ ZMod n) (a b c : Fin n) : Prop :=
  (e b - e a).val < (e c - e a).val

instance {n : ℕ} (e : Fin n ≃ ZMod n) (a b c : Fin n) : Decidable (StateA e a b c) :=
  inferInstanceAs (Decidable ((e b - e a).val < (e c - e a).val))

theorem _root_.LeanGolf.compfiles.usa2010_p2 {n : ℕ} (e : Fin n ≃ ZMod n) (ps : List (ZMod n)) (h : Legal e ps) :
    ps.length ≤ n.choose 3 := by sorry
