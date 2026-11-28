import Mathlib

open Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End

open scoped BigOperators InnerProductSpace

theorem LeanGolf.proofnet.axler_exercise_6_2 {V : Type*} [NormedAddCommGroup V] [Module ℂ V]
[InnerProductSpace ℂ V] (u v : V) :
  ⟪u, v⟫_ℂ = 0 ↔ ∀ (a : ℂ), ‖u‖  ≤ ‖u + a • v‖ := by sorry
