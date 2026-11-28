import Mathlib
import Mathlib.Analysis.Complex.OpenMapping

open Complex Filter Function Metric Finset
open scoped BigOperators Topology

theorem LeanGolf.proofnet.shakarchi_exercise_1_13a {f : ℂ → ℂ} (Ω : Set ℂ) (a b : Ω) (hΩ : IsOpen Ω)
    (hconn : IsPreconnected Ω) (hf : DifferentiableOn ℂ f Ω)
    (hc : ∃ c : ℝ, ∀ z ∈ Ω, (f z).re = c) : f a = f b := by sorry
