import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset
open scoped BigOperators

theorem LeanGolf.proofnet.rudin_exercise_2_27a (k : ℕ) (E P : Set (EuclideanSpace ℝ (Fin k)))
  (hE : ¬ Set.Countable E)
  (hP : P = {x | ∀ U ∈ 𝓝 x, ¬ Set.Countable (U ∩ E)}) :
  Perfect P := by sorry
