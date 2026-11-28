import Mathlib

theorem LeanGolf.minif2f.mathd_algebra_484 :
  Real.log 27 / Real.log 3 = 3 := by field_simp; convert Real.log_pow 3 3 using 1 <;> norm_num [mul_comm]
