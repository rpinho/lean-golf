import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset Metric
open scoped BigOperators

theorem LeanGolf.proofnet.rudin_exercise_3_8
    (a b : ℕ → ℝ)
    (h1 : ∃ y, Tendsto (fun n => ∑ i ∈ range n, a i) atTop (𝓝 y))
    (h2 : Monotone b ∨ Antitone b)
    (h3 : Bornology.IsBounded (Set.range b)) :
    ∃ y, Tendsto (fun n => ∑ i ∈ range n, a i * b i) atTop (𝓝 y) := by sorry
