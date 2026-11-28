import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_1_1_18 {G : Type*} [Group G]
  (x y : G) : (x * y = y * x ↔ y⁻¹ * x * y = x) ∧ (y⁻¹ * x * y = x ↔ x⁻¹ * y⁻¹ * x * y = 1) := by sorry
