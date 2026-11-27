import Mathlib

noncomputable section

open Set Real

namespace Imo1959P2

def IsGood (x A : ℝ) : Prop :=
  sqrt (x + sqrt (2 * x - 1)) + sqrt (x - sqrt (2 * x - 1)) = A ∧ 0 ≤ 2 * x - 1 ∧
    0 ≤ x + sqrt (2 * x - 1) ∧ 0 ≤ x - sqrt (2 * x - 1)

variable {x A : ℝ}

noncomputable abbrev solution_set_sqrt2 : Set ℝ := Icc (1 / 2) 1

theorem _root_.LeanGolf.compfiles.imo1959_p2a : IsGood x (sqrt 2) ↔ x ∈ solution_set_sqrt2 := by sorry
