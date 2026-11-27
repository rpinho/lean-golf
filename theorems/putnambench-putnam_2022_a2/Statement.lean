import Mathlib

noncomputable section

open Polynomial

abbrev putnam_2022_a2_solution : ℕ → ℕ :=
  fun n => 2*n - 2

theorem LeanGolf.putnambench.putnam_2022_a2
(n : ℕ)
(hn : n ≥ 2)
(S : Set ℝ[X])
(hS : S = {P | natDegree P = n})
(negs : ℝ[X] → ℕ)
(hnegs : ∀ P : ℝ[X], negs P = ∑ i ∈ Finset.range (P.natDegree + 1), if P.coeff i < 0 then 1 else 0)
: sSup {negs (P^2) | P ∈ S} = putnam_2022_a2_solution n := by sorry
