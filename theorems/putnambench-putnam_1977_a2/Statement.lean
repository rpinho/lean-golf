import Mathlib

noncomputable section

abbrev putnam_1977_a2_solution : ℝ → ℝ → ℝ → ℝ → Prop :=
  fun a b c d ↦ d = a ∧ b = -c ∨ d = b ∧ a = -c ∨ d = c ∧ a = -b

theorem LeanGolf.putnambench.putnam_1977_a2 :
    ∀ a b c d : ℝ,
      a ≠ 0 → b ≠ 0 → c ≠ 0 → d ≠ 0 →
        (putnam_1977_a2_solution a b c d ↔
          (a + b + c = d ∧ 1 / a + 1 / b + 1 / c = 1 / d)) := by sorry
