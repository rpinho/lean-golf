import Mathlib.Algebra.Order.Star.Real

noncomputable section

namespace Usa1993P5

noncomputable def a_avg (x : ℕ → ℝ) (n : ℕ) : ℝ := (∑ i ∈ Finset.range (n + 1), x i) / (n + 1)

noncomputable def b_avg (x : ℕ → ℝ) (n : ℕ) : ℝ := (∑ i ∈ Finset.range n, x (i + 1)) / n

theorem _root_.LeanGolf.compfiles.usa1993_p5 (x : ℕ → ℝ) (hx : ∀ n, 0 < x n)
    (h : ∀ n, x n * x (n + 2) ≤ x (n + 1) ^ 2)
    (n : ℕ) (hn : 2 ≤ n) :
    a_avg x n * b_avg x (n - 1) ≥ a_avg x (n - 1) * b_avg x n := by sorry
