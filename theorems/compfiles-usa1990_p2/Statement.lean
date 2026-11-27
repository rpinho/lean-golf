import Mathlib.Tactic

noncomputable section

namespace Usa1990P2

noncomputable def f : ℕ → ℝ → ℝ
|     0, _ => 8
| n + 1, x => Real.sqrt (x^2 + 6 * f n x)

abbrev solution_set (n : ℕ) : Set ℝ := { 4 }

theorem _root_.LeanGolf.compfiles.usa1990_p2 (n : ℕ) (x : ℝ) : x ∈ solution_set n ↔ f n x = 2 * x := by sorry
