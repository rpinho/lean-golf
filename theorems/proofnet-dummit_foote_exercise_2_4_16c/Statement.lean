import Mathlib

open Fintype Subgroup Set Polynomial Ideal

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.dummit_foote_exercise_2_4_16c {n : ℕ} (H : AddSubgroup (ZMod n)) :
  ∃ p : (ZMod n), Prime p ∧ H = AddSubgroup.closure {p} ↔
  (H ≠ ⊤ ∧ ∀ K : AddSubgroup (ZMod n), H ≤ K → K = H ∨ K = ⊤) := by sorry
