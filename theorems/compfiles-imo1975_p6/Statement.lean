import Mathlib

noncomputable section

namespace Imo1975P6

open Polynomial

open Polynomial.Bivariate

abbrev solution_set : Set (ℝ[X][Y]) := {P | ∃ n : ℕ, P = (C X - 2 * Y)*(C X + Y)^n}

theorem _root_.LeanGolf.compfiles.imo1975_p6 {P : ℝ[X][Y]} : P ∈ solution_set ↔
    (∃ n : ℕ+, ∀ t x y : ℝ, P.evalEval (t * x) (t * y) = t^n.val * P.evalEval x y)  ∧
    (∀ a b c : ℝ, P.evalEval (b+c) a + P.evalEval (c+a) b + P.evalEval (a+b) c = 0) ∧
    (P.evalEval 1 0 = 1) := by sorry
