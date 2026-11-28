import Mathlib

open Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End InnerProductSpace
open scoped BigOperators ComplexConjugate

theorem LeanGolf.proofnet.axler_exercise_6_13 {V : Type*} [NormedAddCommGroup V] [RCLike F] [InnerProductSpace F V] {n : ℕ}
  {e : Fin n → V} (he : Orthonormal F e) (v : V) :
  ‖v‖^2 = ∑ i : Fin n, ‖⟪v, e i⟫_F‖^2 ↔ v ∈ Submodule.span F (e '' Set.univ) := by sorry
