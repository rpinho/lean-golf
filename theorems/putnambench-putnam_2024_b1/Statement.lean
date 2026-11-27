import Mathlib

noncomputable section

noncomputable abbrev putnam_2024_b1_solution : Set (ℕ × ℕ) :=
  {(2*l+1, l+1) | (l : ℕ)}

theorem LeanGolf.putnambench.putnam_2024_b1
    (grid : (n : ℕ) → ℕ → Fin n → Fin n → ℤ)
    (grid_def : ∀ n k i j, grid n k i j = i.succ + j.succ - k)
    (valid : ℕ → ℕ → Prop)
    (valid_def : ∀ n k, valid n k ↔ 0 < n ∧ 0 < k ∧
      ∃ (f : Fin n → Fin n), f.Injective ∧
        Set.range (fun i => grid n k i (f i)) = Set.Icc (1 : ℤ) n) :
    { (n, k) | valid n k } = putnam_2024_b1_solution := by sorry
