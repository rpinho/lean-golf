import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset
open scoped BigOperators

theorem LeanGolf.proofnet.rudin_exercise_1_1a
  (x : ℝ) (y : ℚ) (hy : y ≠ 0) :
  ( Irrational x ) -> Irrational ( x + y ) := by sorry
