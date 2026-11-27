import Mathlib

open Fintype Set Real Ideal Polynomial

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.herstein_exercise_2_6_15 {G : Type*} [CommGroup G] {m n : ℕ}
  (hm : ∃ (g : G), orderOf g = m)
  (hn : ∃ (g : G), orderOf g = n)
  (hmn : m.Coprime n) :
  ∃ (g : G), orderOf g = m * n := by sorry
