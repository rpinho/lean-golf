import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.rudin_exercise_3_20 {X : Type*} [MetricSpace X]
  (p : ℕ → X) (l : ℕ) (r : X)
  (hp : CauchySeq p)
  (hpl : Tendsto (λ n => p (l * n)) atTop (𝓝 r)) :
  Tendsto p atTop (𝓝 r) := by sorry
