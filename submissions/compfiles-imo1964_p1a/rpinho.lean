import Mathlib.Data.Nat.ModEq
import Mathlib.Tactic

theorem _root_.LeanGolf.compfiles.imo1964_p1a (n : ℕ) : n ∈ solution_set ↔ 2^n ≡ 1 [MOD 7] := by
  induction n using Nat.strongRecOn with
  | ind n H =>
    rcases n with _|(_|(_|n)) <;> try decide
    have := H n (by lia)
    grind [Nat.ModEq,pow_succ]
