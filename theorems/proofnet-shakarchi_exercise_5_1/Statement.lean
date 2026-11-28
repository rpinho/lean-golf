import Mathlib

open Complex Filter Function Metric Finset
open scoped BigOperators Topology

theorem LeanGolf.proofnet.shakarchi_exercise_5_1
    (f : ℂ → ℂ) (hf : DifferentiableOn ℂ f (ball 0 1))
    (hb : Bornology.IsBounded (f '' (ball (0 : ℂ) 1)))
    (h0 : ¬ Set.EqOn f (0 : ℂ → ℂ) (ball (0 : ℂ) 1)) :
    Summable (fun z : {z : ℂ // f z = 0 ∧ z ∈ ball (0 : ℂ) 1} =>
      ((analyticOrderAt f (z : ℂ)).toNat : ℝ) * (1 - ‖(z : ℂ)‖)) := by sorry
