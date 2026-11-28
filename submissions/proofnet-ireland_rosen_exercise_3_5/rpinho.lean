import Mathlib

theorem LeanGolf.proofnet.ireland_rosen_exercise_3_5 : ¬ ∃ x y : ℤ, 7*x^3 + 2 = y^3 := by
  rintro ⟨x,y,h⟩
  have H := congrArg (Int.cast : ℤ → ZMod 7) h
  push_cast at H
  exact (by decide : ∀ a b : ZMod 7, 7*a^3+2 ≠ b^3) _ _ H
