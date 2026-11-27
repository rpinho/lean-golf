import Mathlib.Algebra.Order.Star.Real
import Mathlib.Algebra.Ring.IsFormallyReal
import Mathlib.Analysis.Normed.Field.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

open Finset

namespace Usa2012P6

theorem _root_.LeanGolf.compfiles.usa2012_p6 {n : ℕ} (hn : 2 ≤ n) (x : Fin n → ℝ)
    (hsum : ∑ i, x i = 0) (hsq : ∑ i, x i ^ 2 = 1)
    (lam : ℝ) (hlam : 0 < lam) :
    ((univ.powerset.filter (fun A => lam ≤ ∑ i ∈ A, x i)).card : ℝ) ≤
      (2 : ℝ) ^ ((n : ℤ) - 3) / lam ^ 2 := by sorry
