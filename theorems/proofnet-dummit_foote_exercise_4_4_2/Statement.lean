import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_4_4_2 {G : Type*} [Fintype G] [CommGroup G]
  {p q : Nat.Primes} (hpq : p ≠ q) (hG : card G = p*q) :
  IsCyclic G := by sorry
