import Mathlib

open Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End

open scoped BigOperators InnerProductSpace

theorem LeanGolf.proofnet.axler_exercise_6_13 {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] {n : ℕ}
  {e : Fin n → V} (he : Orthonormal ℂ e) (v : V) :
  ‖v‖^2 = ∑ i : Fin n, ‖⟪v, e i⟫_ℂ‖^2 ↔ v ∈ Submodule.span ℂ (e '' Set.univ) := by sorry
