import Mathlib

noncomputable section

abbrev putnam_2025_a4_solution : ℕ :=
  3

theorem LeanGolf.putnambench.putnam_2025_a4 :
  IsLeast {k : ℕ | ∃ A : Fin 2025 → Matrix (Fin k) (Fin k) ℝ,
    ∀ i j : Fin 2025, i ≤ j →
      (A i * A j = A j * A i ↔ j.val - i.val ∈ ({0, 1, 2024} : Set ℕ))}
  putnam_2025_a4_solution := by sorry
