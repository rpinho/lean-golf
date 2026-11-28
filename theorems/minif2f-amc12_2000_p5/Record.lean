import Mathlib

theorem LeanGolf.minif2f.amc12_2000_p5 (x p : ℝ) (h₀ : x < 2) (h₁ : abs (x - 2) = p) : x - p = 2 - 2 * p := by grind [abs_of_neg (sub_neg.mpr h₀)]
