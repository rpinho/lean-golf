import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.Data.List.Permutation
import Mathlib.Order.ConditionallyCompleteLattice.Basic
import Mathlib.Tactic

noncomputable section

namespace Usa2000P3

inductive Card where
  | blue
  | red
  | white
  deriving BEq, DecidableEq

instance : LawfulBEq Card where
  eq_of_beq := fun {a b} => by
    cases a <;> cases b <;> intro h <;> first | rfl | (exact absurd h (by decide))
  rfl := fun {a} => by cases a <;> rfl

def score : List Card → ℕ
  | [] => 0
  | .blue :: t => t.count .white + score t
  | .red :: t => 3 * t.count .blue + score t
  | .white :: t => 2 * t.count .red + score t

def canonicalPlay (A B C : ℕ) : List Card :=
  List.replicate A .blue ++ (List.replicate B .red ++ List.replicate C .white)

def plays (A B C : ℕ) : Finset (List Card) :=
  (canonicalPlay A B C).permutations.toFinset

abbrev lowestScore (A B C : ℕ) : ℕ := min (min (A * C) (3 * A * B)) (2 * B * C)

abbrev fewestWays (A B C : ℕ) : ℕ :=
  if A = 0 ∧ B = 0 ∧ C = 0 then 1
  else if C = 3 * B ∧ A = 2 * B then A + B + C
  else if C = 3 * B ∧ A < 2 * B then A + 1
  else if 3 * A = 2 * C ∧ 2 * B < A then B + 1
  else if A = 2 * B ∧ C < 3 * B then C + 1
  else 1

variable (A B C : ℕ)

theorem _root_.LeanGolf.compfiles.usa2000_p3 (A B C : ℕ) :
    IsLeast {s : ℕ | ∃ l ∈ plays A B C, score l = s} (lowestScore A B C) ∧
    ((plays A B C).filter (fun l ↦ score l = lowestScore A B C)).card =
      fewestWays A B C := by sorry
