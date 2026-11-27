import Mathlib

open Fintype Set Real Ideal Polynomial

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.herstein_exercise_2_9_2 {G H : Type*} [Fintype G] [Fintype H] [Group G]
  [Group H] (hG : IsCyclic G) (hH : IsCyclic H) :
  IsCyclic (G × H) ↔ (card G).Coprime (card H) := by sorry
