import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

theorem LeanGolf.proofnet.munkres_exercise_21_8
  {X : Type*} [TopologicalSpace X] {Y : Type*} [MetricSpace Y]
  {f : ℕ → X → Y} {x : ℕ → X}
  (hf : ∀ n, Continuous (f n))
  (x₀ : X)
  (hx : Tendsto x atTop (𝓝 x₀))
  (f₀ : X → Y)
  (hh : TendstoUniformly f f₀ atTop) :
  Tendsto (λ n => f n (x n)) atTop (𝓝 (f₀ x₀)) := by sorry
