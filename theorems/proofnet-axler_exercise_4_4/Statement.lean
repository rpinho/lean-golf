import Mathlib

open Fintype Complex Polynomial LinearMap FiniteDimensional Module Module.End
open scoped BigOperators

theorem LeanGolf.proofnet.axler_exercise_4_4 (p : Polynomial ℂ) (m : ℕ) (hp : p ≠ 0) (hm : m = p.degree) :
    @card (p.rootSet ℂ) (rootSetFintype p ℂ) = m ↔
    Disjoint (p.rootSet ℂ) ((Polynomial.derivative p).rootSet ℂ) := by sorry
