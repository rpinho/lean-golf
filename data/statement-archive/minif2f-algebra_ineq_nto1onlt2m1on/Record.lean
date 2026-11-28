import Mathlib

theorem LeanGolf.minif2f.algebra_ineq_nto1onlt2m1on
  (n : ℕ) :
  (n : ℝ) ^ (1 / n : ℝ) ≤ 2 - 1 / n := by
  rcases n.eq_zero_or_pos with rfl|h
  · norm_num
  have h':(0:ℝ)<n:=by exact_mod_cast h
  have:=Real.geom_mean_le_arith_mean2_weighted (w₁:=1/n) (w₂:=1-1/n) (p₁:=n) (p₂:=1) (by positivity) (by rw[sub_nonneg,div_le_one h'];exact_mod_cast h) (by positivity) (by norm_num) (by ring)
  rw[Real.one_rpow,mul_one]at this
  have e:(1/n:ℝ)*n=1:=by field_simp
  linarith
