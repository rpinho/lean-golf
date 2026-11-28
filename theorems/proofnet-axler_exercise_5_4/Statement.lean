import Mathlib

open Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End
open scoped BigOperators

theorem LeanGolf.proofnet.axler_exercise_5_4 {F V : Type*} [AddCommGroup V] [Field F]
    [Module F V] (S T : V →ₗ[F] V) (hST : S ∘ T = T ∘ S) (c : F) :
    Submodule.map S (ker (T - c • LinearMap.id)) ≤ ker (T - c • LinearMap.id) := by sorry
