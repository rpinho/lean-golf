import Mathlib

noncomputable section

open Finset

abbrev putnam_2025_b3_solution : Prop :=
  True

theorem LeanGolf.putnambench.putnam_2025_b3 :
    putnam_2025_b3_solution ↔
    ∀ S : Set ℕ,
      S.Nonempty →
      (∀ n ∈ S, 0 < n) →
      (∀ n ∈ S, ∀ d : ℕ, 0 < d → d ∣ (2025 ^ n - 15 ^ n) → d ∈ S) →
      S = {n : ℕ | 0 < n} := by sorry
