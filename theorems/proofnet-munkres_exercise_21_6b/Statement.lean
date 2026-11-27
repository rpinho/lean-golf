import Mathlib

noncomputable section

open Filter Set TopologicalSpace

open Topology

noncomputable section

abbrev I : Set ℝ := Icc 0 1

theorem LeanGolf.proofnet.munkres_exercise_21_6b
  (f : ℕ → I → ℝ )
  (h : ∀ x n, f n x = x ^ n) :
  ¬ ∃ f₀, TendstoUniformly f f₀ atTop := by sorry
