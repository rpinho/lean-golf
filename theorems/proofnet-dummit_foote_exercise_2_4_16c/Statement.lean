import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_2_4_16c {n : ℕ+} {G : Type*} [Group G] {x : G}
  (hx : orderOf x = n) (hG : closure ({x} : Set G) = ⊤) (H : Subgroup G) :
  (∃ p : ℕ, Prime p ∧ p ∣ n ∧ H = Subgroup.closure {x ^ p}) ↔
  (H ≠ ⊤ ∧ ∀ K : Subgroup G, H ≤ K → K = H ∨ K = ⊤) := by sorry
