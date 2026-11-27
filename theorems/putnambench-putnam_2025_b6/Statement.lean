import Mathlib

noncomputable section

open Real

noncomputable abbrev putnam_2025_b6_solution : ℝ :=
  1 / 4

theorem LeanGolf.putnambench.putnam_2025_b6 :
    IsGreatest
      {r : ℝ | ∃ g : ℕ → ℕ, (∀ n : ℕ, 0 < n → 0 < g n) ∧
        ∀ n : ℕ, 0 < n → ((g (g n) : ℝ) ^ r) ≤ (g (n + 1) : ℝ) - (g n : ℝ)}
      putnam_2025_b6_solution := by sorry
