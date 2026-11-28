import Mathlib

open Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End
open scoped BigOperators

theorem LeanGolf.proofnet.axler_exercise_7_14 {𝕜 V : Type*} [RCLike 𝕜] [NormedAddCommGroup V]
  [InnerProductSpace 𝕜 V] [FiniteDimensional 𝕜 V]
  {T : Module.End 𝕜 V} (hT : IsSelfAdjoint T)
  {l : 𝕜} {ε : ℝ} (he : ε > 0) : (∃ v : V, ‖v‖= 1 ∧ ‖T v - l • v‖ < ε) →
  (∃ l' : T.Eigenvalues, ‖l - l'‖ < ε) := by sorry
