import Mathlib

open Fintype Set Real Ideal Polynomial
open scoped BigOperators

theorem LeanGolf.proofnet.herstein_exercise_2_7_7 {G : Type*} [Group G] {G' : Type*} [Group G']
    (φ : G →* G') (hφ : Function.Surjective φ) (N : Subgroup G) [N.Normal] :
    (Subgroup.map φ N).Normal := by sorry
