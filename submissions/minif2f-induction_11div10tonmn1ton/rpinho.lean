import Mathlib

theorem LeanGolf.minif2f.induction_11div10tonmn1ton
  (n : ℕ) :
  11 ∣ (10^n - (-1 : ℤ)^n) := sub_dvd_pow_sub_pow _ _ _
