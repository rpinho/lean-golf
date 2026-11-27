import Mathlib.Tactic

noncomputable section

namespace Imo1968P3

open Cardinal Finset

def solution_set (n : ℕ) (a b c : ℝ) : Set (ℕ → ℝ) := {x : ℕ → ℝ |
 (∀ i < n, a * (x i)^2 + b * (x i) + c = x (i+1)) ∧
 (a * (x n)^2 + b * (x n) + c = x 0) ∧ (∀ i > n, x i = 0)}

theorem _root_.LeanGolf.compfiles.imo1968_p3 {n : ℕ} (a b c : ℝ) (a_ne_zero : a ≠ 0) :
  (discrim a (b-1) c < 0 → #(solution_set n a b c) = 0) ∧
  (discrim a (b-1) c = 0 → #(solution_set n a b c) = 1) ∧
  (discrim a (b-1) c > 0 → #(solution_set n a b c) > 1) := by sorry
