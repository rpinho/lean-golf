import Mathlib

noncomputable section

noncomputable abbrev putnam_2018_a3_solution : ℝ :=
  480/49

theorem LeanGolf.putnambench.putnam_2018_a3 :
    IsGreatest
      {∑ i, Real.cos (3 * x i) | (x : Fin 10 → ℝ) (hx : ∑ i, Real.cos (x i) = 0)}
      putnam_2018_a3_solution := by sorry
