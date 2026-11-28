import Mathlib

theorem LeanGolf.minif2f.imo_1959_p1
  (n : ℕ)
  (h₀ : 0 < n) :
  Nat.gcd (21*n + 4) (14*n + 3) = 1 := by
  apply Nat.dvd_one.mp
  convert Nat.dvd_sub (dvd_mul_of_dvd_right (Nat.gcd_dvd_right _ _) 3)
    (dvd_mul_of_dvd_right (Nat.gcd_dvd_left _ _) 2) using 1 <;> omega
