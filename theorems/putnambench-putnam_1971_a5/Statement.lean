import Mathlib

noncomputable section

open Set MvPolynomial

abbrev putnam_1971_a5_solution : ℤ × ℤ :=
  (11, 8)

theorem LeanGolf.putnambench.putnam_1971_a5
    (a b : ℤ)
    (hab : a > 0 ∧ b > 0 ∧ a > b)
    (pab : ℤ → ℤ → Prop)
    (hpab : ∀ x y, pab x y ↔
      {s : ℕ | ¬∃ m n : ℕ, m*x + n*y = s}.ncard = 35 ∧
      ¬∃ m n : ℕ, m*x + n*y = 58) :
    pab a b ↔ a = putnam_1971_a5_solution.1 ∧ b = putnam_1971_a5_solution.2 := by sorry
