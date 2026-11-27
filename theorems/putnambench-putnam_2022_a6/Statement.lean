import Mathlib

noncomputable section

open Set

abbrev putnam_2022_a6_solution : ℕ → ℕ :=
  (fun n : ℕ => n)

theorem LeanGolf.putnambench.putnam_2022_a6
    (n : ℕ) (hn : 0 < n) :
    IsGreatest
      {m : ℕ | ∃ x : ℕ → ℝ,
        StrictMono x ∧ -1 < x 1 ∧ x (2 * n) < 1 ∧
        ∀ k ∈ Icc 1 m, ∑ i ∈ Icc 1 n, ((x (2 * i) : ℝ) ^ (2 * k - 1) - (x (2 * i - 1)) ^ (2 * k - 1)) = 1}
    (putnam_2022_a6_solution n) := by sorry
