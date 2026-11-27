import Mathlib

noncomputable section

open scoped Real

open scoped Topology

noncomputable abbrev putnam_2024_b6_solution : ℝ :=
  -1/2

theorem LeanGolf.putnambench.putnam_2024_b6
    (F : ℝ → ℝ → ℝ) (c : ℝ)
    (hF : ∀ a, ∀ x ∈ Set.Ico 0 1,
      HasSum (fun (n : ℕ) => (n+1)^a * rexp (2*(n+1)) * x^(n+1)^2) (F a x)) :
    ((∀ a < c, Filter.Tendsto (fun x => F a x * rexp (- 1 / (1-x))) (𝓝[<] 1) (𝓝 0)) ∧
    (∀ a > c, Filter.Tendsto (fun x => F a x * rexp (- 1 / (1-x))) (𝓝[<] 1) Filter.atTop))
    ↔ c = putnam_2024_b6_solution := by sorry
