import Mathlib

open Topology Filter

theorem LeanGolf.putnambench.putnam_2019_a6
(g : ℝ → ℝ)
(r : ℝ)
(hcont : ContinuousOn g (Set.Icc 0 1))
(hdiff : ContDiffOn ℝ 1 g (Set.Ioo 0 1) ∧ DifferentiableOn ℝ (deriv g) (Set.Ioo 0 1))
(hr : r > 1)
(hlim : Tendsto (fun x => g x / x ^ r) (𝓝[>] 0) (𝓝 0))
: (Tendsto (deriv g) (𝓝[>] 0) (𝓝 0)) ∨ (Tendsto (fun x : ℝ => sSup {((x' ^ r * abs (iteratedDeriv 2 g x') : ℝ) : WithTop ℝ) | x' ∈ Set.Ioc 0 x}) (𝓝[>] 0) atTop) := by sorry
