import Mathlib

open Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End

open scoped BigOperators InnerProductSpace

theorem LeanGolf.proofnet.axler_exercise_6_16 {K V : Type*} [RCLike K] [NormedAddCommGroup V] [InnerProductSpace K V]
  {U : Submodule K V} :
  U.orthogonal = ⊥  ↔ U = ⊤ := by sorry
