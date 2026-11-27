import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Ring

theorem LeanGolf.sum_odds (n : ℕ) :
    (Finset.range n).sum (fun i => 2 * i + 1) = n ^ 2 := by sorry
