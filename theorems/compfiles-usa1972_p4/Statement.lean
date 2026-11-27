import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Algebra.Order.Star.Real
import Mathlib.Algebra.Ring.IsFormallyReal
import Mathlib
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.LinearCombination.Lemmas
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa1972P4

abbrev IsSolution (A B C a b c : ℤ) (k : ℝ) : Prop :=
  ∀ x : ℚ, 0 ≤ x →
    |((A : ℝ) * (x : ℝ) ^ 2 + (B : ℝ) * (x : ℝ) + (C : ℝ)) /
        ((a : ℝ) * (x : ℝ) ^ 2 + (b : ℝ) * (x : ℝ) + (c : ℝ)) - k| <
      |(x : ℝ) - k|

abbrev solution : ℤ × ℤ × ℤ × ℤ × ℤ × ℤ := (2, 2, 2, 1, 2, 2)

theorem _root_.LeanGolf.compfiles.usa1972_p4 (k : ℝ) (hk : k ^ 3 = 2) :
    match solution with
    | (A, B, C, a, b, c) => IsSolution A B C a b c k := by sorry
