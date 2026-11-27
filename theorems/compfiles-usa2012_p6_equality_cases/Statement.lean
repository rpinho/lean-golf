import Mathlib.Algebra.Order.Star.Real
import Mathlib.Algebra.Ring.IsFormallyReal
import Mathlib.Analysis.Normed.Field.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

noncomputable section

open Finset

namespace Usa2012P6

abbrev equality_cases {n : ℕ} (x : Fin n → ℝ) (lam : ℝ) : Prop :=
  ∃ i j : Fin n, i ≠ j ∧ x i = 1 / Real.sqrt 2 ∧ x j = -(1 / Real.sqrt 2) ∧
    (∀ k : Fin n, k ≠ i → k ≠ j → x k = 0) ∧ lam = 1 / Real.sqrt 2

theorem _root_.LeanGolf.compfiles.usa2012_p6_equality_cases {n : ℕ} (hn : 2 ≤ n) (x : Fin n → ℝ)
    (hsum : ∑ i, x i = 0) (hsq : ∑ i, x i ^ 2 = 1)
    (lam : ℝ) (hlam : 0 < lam) :
    ((univ.powerset.filter (fun A => lam ≤ ∑ i ∈ A, x i)).card : ℝ) =
        (2 : ℝ) ^ ((n : ℤ) - 3) / lam ^ 2 ↔
      equality_cases x lam := by sorry
