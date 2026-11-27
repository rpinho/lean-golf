import Mathlib.Analysis.MeanInequalities
import Mathlib.Algebra.Order.Group.Nat
import Mathlib.Data.Finset.Max
import Mathlib.Data.Fintype.Powerset
import Mathlib.Data.Set.Monotone
import Mathlib.Order.Interval.Finset.Nat

noncomputable section

open Finset Function

namespace Imo2025P6

variable {n : ℕ}

abbrev Point (n : ℕ) := Fin n × Fin n

variable {all_black : Finset (Point n)}

section ProblemSetup

variable [NeZero n]

abbrev px (p : Point n) : ℕ := p.1.val

abbrev py (p : Point n) : ℕ := p.2.val

structure Matilda (n : ℕ) [NeZero n] (all_black : Finset (Point n)) where
  x_min : ℕ
  x_max : ℕ
  y_min : ℕ
  y_max : ℕ
  h_x_le : x_min ≤ x_max
  h_y_le : y_min ≤ y_max
  h_x_bound : x_max < n
  h_y_bound : y_max < n
  h_disjoint : ∀ p ∈ all_black, ¬(x_min ≤ px p ∧ px p ≤ x_max ∧ y_min ≤ py p ∧ py p ≤ y_max)

def Matilda.mem (m : Matilda n all_black) (p : Point n) : Prop :=
  m.x_min ≤ px p ∧ px p ≤ m.x_max ∧ m.y_min ≤ py p ∧ py p ≤ m.y_max

def IsValidConfiguration (n : ℕ) [NeZero n]
  (all_black : Finset (Point n)) (partition : Finset (Matilda n all_black)) : Prop :=
  all_black.card = n ∧
  (∀ p ∈ all_black, ∀ q ∈ all_black, px p = px q → p = q) ∧
  (∀ p ∈ all_black, ∀ q ∈ all_black, py p = py q → p = q) ∧
  (∀ p : Point n, p ∉ all_black → ∃! m ∈ partition, m.mem p)

def IsMinMatildaCount (n : ℕ) [NeZero n] (m : ℕ) : Prop :=
  (∀ (all_black : Finset (Point n)) (partition : Finset (Matilda n all_black)),
      IsValidConfiguration n all_black partition → m ≤ partition.card) ∧
  (∃ (all_black : Finset (Point n)) (partition : Finset (Matilda n all_black)),
      IsValidConfiguration n all_black partition ∧ partition.card = m)

end ProblemSetup

abbrev solution_value : ℕ := 2112

theorem _root_.LeanGolf.compfiles.imo2025_p6 : IsMinMatildaCount 2025  solution_value := by sorry
