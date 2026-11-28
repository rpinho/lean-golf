import Mathlib

open Complex Filter Function Metric Finset
open scoped BigOperators Topology

theorem LeanGolf.proofnet.shakarchi_exercise_2_13
    {f : ℂ → ℂ}
    (hf_diff : Differentiable ℂ f)
    (hf_vanish : ∀ z₀ : ℂ, ∃ n : ℕ,
      iteratedDeriv n f z₀ / (n.factorial : ℂ) = 0) :
    ∃ (p : Polynomial ℂ), f = fun z => Polynomial.aeval z p := by sorry
