import Mathlib

noncomputable section

open Filter Set TopologicalSpace

open Topology

noncomputable section

abbrev I : Set ℝ := Icc 0 1

theorem LeanGolf.proofnet.munkres_exercise_21_6a
  (f : ℕ → I → ℝ )
  (h : ∀ x n, f n x = x ^ n) :
  ∀ x, ∃ y, Tendsto (λ n => f n x) atTop (𝓝 y) := by sorry
