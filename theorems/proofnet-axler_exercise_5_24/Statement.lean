import Mathlib

open Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End

open scoped BigOperators InnerProductSpace

theorem LeanGolf.proofnet.axler_exercise_5_24 {V : Type*} [AddCommGroup V]
  [Module ℝ V] [FiniteDimensional ℝ V] {T : End ℝ V}
  (hT : ∀ c : ℝ, eigenspace T c = ⊥) {U : Submodule ℝ V}
  (hU : Submodule.map T U = U) : Even (finrank U) := by sorry
