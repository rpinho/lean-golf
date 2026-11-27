import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

theorem LeanGolf.sum_cubes (n : ℕ) :
    (Finset.range (n + 1)).sum (fun i => i ^ 3) = ((Finset.range (n + 1)).sum id) ^ 2 := by
  have ht (m : ℕ) : 2 * (Finset.range (m + 1)).sum id = m * (m + 1) := by
    induction m with
    | zero => decide
    | succ m ih =>
      rw [Finset.sum_range_succ, id, Nat.mul_add, ih]
      ring
  induction n with
  | zero => decide
  | succ n ih =>
    have h := congrArg (fun t : ℕ => t * (n + 1)) (ht n)
    rw [Finset.sum_range_succ (fun i : ℕ => i ^ 3) (n + 1),
      Finset.sum_range_succ (id : ℕ → ℕ) (n + 1), ih]
    change _ + (n + 1) ^ 3 = (_ + (n + 1)) ^ 2
    nlinarith only [h]
