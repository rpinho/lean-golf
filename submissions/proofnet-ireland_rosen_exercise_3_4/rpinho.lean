import Mathlib

theorem LeanGolf.proofnet.ireland_rosen_exercise_3_4 : ¬ ∃ x y : ℤ, 3*x^2 + 2 = y^2 := by
  rintro ⟨x,y,h⟩
  have e : y^2%3=2 := by omega
  rw [sq,Int.mul_emod] at e
  have : y%3=0 ∨ y%3=1 ∨ y%3=2 := by omega
  grind
