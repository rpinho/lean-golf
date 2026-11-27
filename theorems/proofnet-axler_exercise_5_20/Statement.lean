import Mathlib

open Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End

open scoped BigOperators InnerProductSpace

theorem LeanGolf.proofnet.axler_exercise_5_20 {F V : Type*} [AddCommGroup V] [Field F]
  [Module F V] [FiniteDimensional F V] {S T : End F V}
  (h1 : card (T.Eigenvalues) = finrank F V)
  (h2 : ∀ v : V, ∃ c : F, v ∈ eigenspace S c ↔ ∃ c : F, v ∈ eigenspace T c) :
  S * T = T * S := by sorry
