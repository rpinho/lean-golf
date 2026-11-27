import Mathlib

noncomputable section

abbrev putnam_2018_b3_solution : Set ℕ :=
  {2^2, 2^4, 2^16, 2^256}

theorem LeanGolf.putnambench.putnam_2018_b3
  (n : ℕ) (hn : 0 < n) :
  (n < 10^100 ∧ ((n : ℤ) ∣ (2^n : ℤ) ∧ (n - 1 : ℤ) ∣ (2^n - 1 : ℤ) ∧ (n - 2 : ℤ) ∣ (2^n - 2 : ℤ))) ↔ n ∈ putnam_2018_b3_solution := by sorry
