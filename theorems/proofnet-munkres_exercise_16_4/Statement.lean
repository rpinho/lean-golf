import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

theorem LeanGolf.proofnet.munkres_exercise_16_4 {X Y : Type*} [TopologicalSpace X] [TopologicalSpace Y]
  (π₁ : X × Y → X)
  (π₂ : X × Y → Y)
  (h₁ : π₁ = Prod.fst)
  (h₂ : π₂ = Prod.snd) :
  IsOpenMap π₁ ∧ IsOpenMap π₂ := by sorry
