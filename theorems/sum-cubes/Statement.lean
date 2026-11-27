import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

theorem LeanGolf.sum_cubes (n : ℕ) :
    (Finset.range (n + 1)).sum (fun i => i ^ 3) = ((Finset.range (n + 1)).sum id) ^ 2 := by sorry
