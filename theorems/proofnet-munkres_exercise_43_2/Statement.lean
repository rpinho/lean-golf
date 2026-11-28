import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

theorem LeanGolf.proofnet.munkres_exercise_43_2 {X : Type*} [MetricSpace X]
    {Y : Type*} [MetricSpace Y] [CompleteSpace Y] (A : Set X)
    (f : X → Y) (hf : UniformContinuousOn f A) :
    ∃ (g : closure A → Y),
      UniformContinuous g ∧
        (∀ x : A, g ⟨x, subset_closure x.property⟩ = f x) ∧
        (∀ g' : closure A → Y, Continuous g' →
          (∀ x : A, g' ⟨x, subset_closure x.property⟩ = f x) → g' = g) := by sorry
