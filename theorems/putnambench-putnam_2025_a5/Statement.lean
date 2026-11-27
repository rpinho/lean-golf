import Mathlib

noncomputable section

open Finset

abbrev putnam_2025_a5_solution : (n : ℕ) → Set (Fin n → ℤˣ) :=
  fun n => {s | (∀ i : Fin n, s i = (-1) ^ (i.val + 1)) ∨ (∀ i : Fin n, s i = (-1) ^ i.val)}

def f (n : ℕ) (s : Fin n → ℤˣ) : ℕ :=
  Finset.card {σ : Equiv.Perm (Fin (n + 1)) |
    ∀ i : Fin n, 0 < (s i : ℤ) * ((σ i.succ : ℤ) - (σ i.castSucc : ℤ))}

theorem LeanGolf.putnambench.putnam_2025_a5
    (n : ℕ)
    (hn : 1 ≤ n)
    (s : Fin n → ℤˣ) :
    (∀ t : Fin n → ℤˣ, f n t ≤ f n s) ↔ s ∈ putnam_2025_a5_solution n := by sorry
