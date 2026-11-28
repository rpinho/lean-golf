import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset
open scoped BigOperators

theorem LeanGolf.proofnet.rudin_exercise_2_24
    {X : Type*} [MetricSpace X]
    (hBW : ∀ A : Set X, A.Infinite → ∃ p : X, AccPt p (𝓟 A)) :
    SeparableSpace X := by sorry
