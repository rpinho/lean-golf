import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset
open scoped BigOperators

theorem LeanGolf.proofnet.rudin_exercise_1_5 (A minus_A : Set ℝ) (hA : A.Nonempty)
  (hA_bdd_below : BddBelow A) (hminus_A : minus_A = {x | -x ∈ A}) :
  sInf A = - sSup minus_A := by sorry
