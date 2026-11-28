import Mathlib

open Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End
open scoped BigOperators ENNReal ComplexConjugate

theorem LeanGolf.proofnet.axler_exercise_6_16 {K V : Type*} [RCLike K] [NormedAddCommGroup V]
  [InnerProductSpace K V] [CompleteSpace V] {U : Submodule K V}
  (hU : IsClosed (U : Set V)) :
  U.orthogonal = ⊥ ↔ U = ⊤ := by sorry
