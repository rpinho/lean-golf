import Mathlib

noncomputable section

abbrev putnam_2017_a1_solution : Set ℤ :=
  {x : ℤ | x > 0 ∧ (x = 1 ∨ 5 ∣ x)}

theorem LeanGolf.putnambench.putnam_2017_a1
    (IsQualifying : Set ℤ → Prop)
    (IsQualifying_def : ∀ S, IsQualifying S ↔
      (∀ n ∈ S, 0 < n) ∧
      2 ∈ S ∧
      (∀ n > 0, n ^ 2 ∈ S → n ∈ S) ∧
      (∀ n ∈ S, (n + 5) ^ 2 ∈ S))
    (S : Set ℤ)
    (hS : IsLeast IsQualifying S) :
    Sᶜ ∩ {n | 0 < n} = putnam_2017_a1_solution := by sorry
