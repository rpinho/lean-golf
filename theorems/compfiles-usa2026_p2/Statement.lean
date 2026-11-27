import Mathlib.Tactic
import Mathlib.Data.Nat.Find
import Mathlib.Logic.Relation
import Mathlib.Algebra.Order.GroupWithZero.Basic

noncomputable section

namespace Usa2026P2

def IsPow2 (x : ℕ) : Prop := ∃ k, x = 2 ^ k

inductive Move : List ℕ → List ℕ → Prop
  | mk (l r : List ℕ) (x y z : ℕ) (hz : IsPow2 z) (hx : x < z) (hy : y < z) :
      Move (l ++ x :: y :: r) (l ++ z :: r)

theorem _root_.LeanGolf.compfiles.usa2026_p2 (a : List ℕ) (ha : a ≠ []) (hp : ∀ x ∈ a, IsPow2 x) :
    ∃ m, Relation.ReflTransGen Move a [m] ∧ m < 4 * a.sum := by sorry
