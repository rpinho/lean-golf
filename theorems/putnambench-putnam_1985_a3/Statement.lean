import Mathlib

noncomputable section

open Set Filter Topology Real

noncomputable abbrev putnam_1985_a3_solution : ℝ → ℝ :=
  fun d ↦ exp d - 1

theorem LeanGolf.putnambench.putnam_1985_a3
(d : ℝ)
(a : ℕ → ℕ → ℝ)
(ha0 : ∀ m : ℕ, a m 0 = d / 2 ^ m)
(ha : ∀ m : ℕ, ∀ j : ℕ, a m (j + 1) = (a m j) ^ 2 + 2 * a m j)
: Tendsto (fun n ↦ a n n) atTop (𝓝 (putnam_1985_a3_solution d)) := by sorry
