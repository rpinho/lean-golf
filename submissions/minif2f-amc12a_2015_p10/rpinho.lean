import Mathlib

theorem LeanGolf.minif2f.amc12a_2015_p10 (x y : ℤ) (h₀ : 0 < y) (h₁ : y < x) (h₂ : x + y + x * y = 80) : x = 26 := by
  have:y<9:=by nlinarith
  interval_cases y<;>omega
