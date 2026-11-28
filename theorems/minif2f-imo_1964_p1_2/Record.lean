import Mathlib

theorem LeanGolf.minif2f.imo_1964_p1_2 (n : ℕ) : ¬7 ∣ 2 ^ n + 1 := by
  have : 2^n%7=1 ∨ 2^n%7=2 ∨ 2^n%7=4 := by induction n <;> simp_all [pow_succ] <;> omega
  omega
