import Mathlib

open Filter Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End
open scoped BigOperators

theorem LeanGolf.proofnet.axler_exercise_5_24 {V : Type*} [AddCommGroup V]
  [Module ℝ V] [FiniteDimensional ℝ V] {T : End ℝ V}
  (hT : ∀ c : ℝ, eigenspace T c = ⊥) {U : Submodule ℝ V}
  (hU : Submodule.map T U ≤ U) : Even (finrank ℝ U) := by sorry
