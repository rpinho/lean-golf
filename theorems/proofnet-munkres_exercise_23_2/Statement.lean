import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

theorem LeanGolf.proofnet.munkres_exercise_23_2 {X : Type*}
  [TopologicalSpace X] {A : ℕ → Set X} (hA : ∀ n, IsConnected (A n))
  (hAn : ∀ n, A n ∩ A (n + 1) ≠ ∅) :
  IsConnected (⋃ n, A n) := by sorry
