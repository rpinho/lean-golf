import Mathlib

open Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End
open scoped BigOperators ComplexOrder

theorem LeanGolf.proofnet.axler_exercise_7_6 {V : Type*} [NormedAddCommGroup V] [RCLike F] [InnerProductSpace F V]
  [FiniteDimensional F V] (T : End F V)
  (hT : T * adjoint T = adjoint T * T) :
  range T = range (adjoint T) := by sorry
