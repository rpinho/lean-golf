import Mathlib

noncomputable section

open Filter Topology

abbrev putnam_2021_a1_solution : ℕ :=
  578

theorem LeanGolf.putnambench.putnam_2021_a1
    (P : List (ℤ × ℤ) → Prop)
    (P_def : ∀ l, P l ↔ l.Chain' fun p q ↦ (p.1 - q.1) ^ 2 + (p.2 - q.2) ^ 2 = 25) :
    IsLeast
      {k | ∃ l, P ((0, 0) :: l) ∧ l.getLast! = (2021, 2021) ∧ l.length = k}
      putnam_2021_a1_solution := by sorry
