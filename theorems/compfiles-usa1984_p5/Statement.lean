import Mathlib.Tactic

noncomputable section

namespace Usa1984P5

open Polynomial

abbrev solution_value : ℕ := 4

theorem _root_.LeanGolf.compfiles.usa1984_p5 (n : ℕ) (hn : 0 < n) (P : ℝ[X])
    (hdeg : P.natDegree = 3 * n)
    (h0 : ∀ k ∈ Finset.range (n + 1), P.eval (((3 * k : ℕ) : ℝ)) = 2)
    (h1 : ∀ k ∈ Finset.range n, P.eval (((3 * k + 1 : ℕ) : ℝ)) = 1)
    (h2 : ∀ k ∈ Finset.range n, P.eval (((3 * k + 2 : ℕ) : ℝ)) = 0)
    (h730 : P.eval (((3 * n + 1 : ℕ) : ℝ)) = 730) :
    n = solution_value := by sorry
