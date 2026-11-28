import Mathlib
import Aesop


open BigOperators Real Nat Topology Rat

theorem LeanGolf.minif2f.mathd_algebra_188
  (f : ℝ → ℝ)
  (h₀ : Function.Bijective f)
  (h₁ : f 2 = 4)
  (h₂ : f 2 = Function.invFun f 2) :
  f (f 2) = 2 := by sorry
