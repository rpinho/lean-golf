import Mathlib

open InnerProductSpace RCLike ContinuousLinearMap Complex
open scoped BigOperators

theorem LeanGolf.proofnet.axler_exercise_6_2 {V : Type*} [NormedAddCommGroup V] {F : Type*}
    [RCLike F] [InnerProductSpace F V]
    (u v : V) :
    ⟪u, v⟫_F = 0 ↔ ∀ (a : F), ‖u‖ ≤ ‖u + a • v‖ := by sorry
