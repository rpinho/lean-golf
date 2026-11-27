import Mathlib.Data.Nat.GCD.Basic

theorem LeanGolf.imo_1959_p1 (n : ℕ) : Nat.gcd (21 * n + 4) (14 * n + 3) = 1 := by
  have h := Nat.dvd_sub
    (Nat.dvd_mul_left_of_dvd (Nat.gcd_dvd_right (21 * n + 4) (14 * n + 3)) 3)
    (Nat.dvd_mul_left_of_dvd (Nat.gcd_dvd_left (21 * n + 4) (14 * n + 3)) 2)
  rw [show 3 * (14 * n + 3) - 2 * (21 * n + 4) = 1 by omega] at h
  exact Nat.dvd_one.mp h
