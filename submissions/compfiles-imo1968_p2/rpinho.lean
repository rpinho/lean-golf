import Mathlib.Data.Nat.Digits.Lemmas
import Mathlib.Tactic

theorem _root_.LeanGolf.compfiles.imo1968_p2 (x : ℕ) :
    x ∈ solution_set ↔
    x^2 = 10 * x + 22 + (Nat.digits 10 x).prod := by
  have B(n:ℕ) : (Nat.digits 10 n).prod ≤ n+1 := by
    induction n using Nat.strongRecOn with
    | ind n H =>
      obtain rfl|h := Nat.eq_zero_or_pos n
      · decide
      rw [Nat.digits_def' (by decide) h,List.prod_cons]
      have := H (n/10) (by lia)
      have : n%10<10 := by lia
      interval_cases h:n%10 <;> omega
  constructor
  · rintro (rfl : x=12); decide
  · intro h
    have := B x
    have : x≤13 := by nlinarith
    interval_cases x <;> revert h <;> decide
