import Mathlib

open Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End

open scoped BigOperators InnerProductSpace

theorem LeanGolf.proofnet.axler_exercise_4_4 (p : Polynomial ℂ) :
  p.degree = @card (rootSet p ℂ) (rootSetFintype p ℂ) ↔
  Disjoint
  (@card (rootSet (derivative p) ℂ) (rootSetFintype (derivative p) ℂ))
  (@card (rootSet p ℂ) (rootSetFintype p ℂ)) := by sorry
