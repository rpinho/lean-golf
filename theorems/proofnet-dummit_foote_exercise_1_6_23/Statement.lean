import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_1_6_23 {G : Type*} [Group G] [Finite G]
    (σ : MulAut G) (hs : ∀ g : G, σ g = g ↔ g = 1)
    (hs2 : ∀ g : G, σ (σ g) = g) :
    ∀ x y : G, x * y = y * x := by sorry
