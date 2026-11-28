import Mathlib

theorem LeanGolf.minif2f.mathd_numbertheory_156 (n : ℕ) (h₀ : 0 < n) : Nat.gcd (n + 7) (2 * n + 1) ≤ 13 := le_of_dvd (by decide) (by convert Nat.dvd_sub ((Nat.gcd_dvd_left _ _).mul_left 2) (Nat.gcd_dvd_right _ _) <;> omega)
