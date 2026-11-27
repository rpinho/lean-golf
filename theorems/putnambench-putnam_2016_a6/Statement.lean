import Mathlib

noncomputable section

open Polynomial Filter Topology Real Set Nat List

noncomputable abbrev putnam_2016_a6_solution : ℝ :=
  5 / 6

theorem LeanGolf.putnambench.putnam_2016_a6
  (p : ℝ → Prop)
  (hp : ∀ c, p c ↔
          ∀ P : Polynomial ℝ, P.degree = 3 →
          (∃ x ∈ Icc 0 1, P.eval x = 0) →
          ∫ x in (0)..1, |P.eval x| ≤ c * (sSup {y | ∃ x ∈ Icc 0 1, y = |P.eval x|})) :
  IsLeast p putnam_2016_a6_solution := by sorry
