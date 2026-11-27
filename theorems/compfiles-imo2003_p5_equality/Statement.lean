import Mathlib.Algebra.CharP.Defs
import Mathlib.Algebra.EuclideanDomain.Basic
import Mathlib.Algebra.EuclideanDomain.Field
import Mathlib.Algebra.Order.Star.Real
import Mathlib.Algebra.Ring.IsFormallyReal
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.LinearCombination.Lemmas
import Mathlib.Tactic.Linarith

namespace Imo2003P5

open Finset

theorem _root_.LeanGolf.compfiles.imo2003_p5_equality (n : ℕ) (hn : 2 < n) (x : ℕ → ℝ) (hx : MonotoneOn x (range n)) :
    (∑ i ∈ range n, ∑ j ∈ range n, |x i - x j|) ^ 2 =
      2 / 3 * ((n : ℝ) ^ 2 - 1) * ∑ i ∈ range n, ∑ j ∈ range n, (x i - x j) ^ 2 ↔
    ∃ a d : ℝ, ∀ i ∈ range n, x i = a + d * (i : ℝ) := by sorry
