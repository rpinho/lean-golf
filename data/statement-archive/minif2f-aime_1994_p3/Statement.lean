import Mathlib

open BigOperators Real Nat Topology Rat

theorem LeanGolf.minif2f.aime_1994_p3
  (f : ℤ → ℤ)
  (h0 : ∀ x, f x + f (x - 1) = x^2)
  (h1 : f 19 = 94) :
  f 94 % 1000 = 561 := by sorry
