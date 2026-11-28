import Mathlib

open Complex Filter Function Metric Finset
open scoped BigOperators Topology

theorem LeanGolf.proofnet.shakarchi_exercise_1_13b {f : ℂ → ℂ} {Ω : Set ℂ}
    (hΩ : IsOpen Ω) (hConn : IsPreconnected Ω)
    (hf : DifferentiableOn ℂ f Ω)
    (hc : ∃ c : ℝ, ∀ z ∈ Ω, (f z).im = c) :
    ∀ a b : Ω, f a = f b := by sorry
