import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Data.Nat.Dist
import Mathlib
import Mathlib.Order.Interval.Set.Infinite
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa2004P4

abbrev Cell : Type := Fin 6 × Fin 6

def Adj (x y : Cell) : Prop := Nat.dist x.1.1 y.1.1 ≤ 1 ∧ Nat.dist x.2.1 y.2.1 ≤ 1

def IsBlack (f : Cell → ℚ) (c : Cell) : Prop := ∀ d : Cell, d.1 = c.1 → f d ≤ f c

def AliceWins (f : Cell → ℚ) : Prop :=
  ∃ c d : Cell, c.1.1 = 0 ∧ d.1.1 = 5 ∧ IsBlack f c ∧ IsBlack f d ∧
    Relation.ReflTransGen (fun x y => Adj x y ∧ IsBlack f x ∧ IsBlack f y) c d

structure Play where
  moves : Fin 36 → Cell × ℚ
  cell_inj : Function.Injective fun i => (moves i).1
  val_inj : Function.Injective fun i => (moves i).2

noncomputable def prefBoard (p : Play) (n : ℕ) : Cell → Option ℚ :=
  fun c => if h : ∃ i : Fin 36, (i : ℕ) < n ∧ (p.moves i).1 = c
    then some (p.moves h.choose).2
    else none

noncomputable def finalBoard (p : Play) : Cell → ℚ :=
  fun c => (prefBoard p 36 c).getD 0

def FollowsStrategy (σ : (Cell → Option ℚ) → Cell × ℚ) (p : Play) : Prop :=
  ∀ k : Fin 36, Odd (k : ℕ) → p.moves k = σ (prefBoard p k)

theorem _root_.LeanGolf.compfiles.usa2004_p4 :
    ∃ σ : (Cell → Option ℚ) → Cell × ℚ,
      ∀ p : Play, FollowsStrategy σ p → ¬ AliceWins (finalBoard p) := by sorry
