import Mathlib

open Fintype Subgroup Set Polynomial Ideal

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.dummit_foote_exercise_7_2_12 {R G : Type*} [Ring R] [Group G] [Fintype G] :
  ∑ g : G, MonoidAlgebra.of R G g ∈ center (MonoidAlgebra R G) := by sorry
