import Mathlib.Tactic

noncomputable section

namespace Imo2012P4

def odd_const : Set (ℤ → ℤ) := { f |
  ∃ c : ℤ, ∀ x : ℤ,
    (Odd x → f x = c) ∧ (Even x → f x = 0) }

def mod4_cycle : Set (ℤ → ℤ) := { f |
  ∃ c : ℤ, ∀ x : ℤ, f x =
  match x % 4 with
    | 0 => 0
    | 2 => 4 * c
    | _ => c }

def square_set : Set (ℤ → ℤ) := { f |
  ∃ c : ℤ, ∀ x : ℤ, f x = x ^ 2 * c }

abbrev solution_set : Set (ℤ → ℤ) := odd_const ∪ mod4_cycle ∪ square_set

theorem _root_.LeanGolf.compfiles.imo2012_p4 (f : ℤ → ℤ) :
    f ∈ solution_set ↔
    ∀ a b c : ℤ, a + b + c = 0 →
      (f a)^2 + (f b)^2 + (f c)^2 =
        2 * f a * f b + 2 * f b * f c + 2 * f c * f a := by sorry
