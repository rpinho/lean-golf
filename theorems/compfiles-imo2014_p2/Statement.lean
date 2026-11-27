import Mathlib

noncomputable section

namespace Imo2014P2

variable {n : ℕ}

def HasEmptySquare (σ : Equiv.Perm (Fin n)) (k : ℕ) : Prop :=
  ∃ r c : ℕ, r + k ≤ n ∧ c + k ≤ n ∧
    ∀ i : Fin n, r ≤ (i : ℕ) → (i : ℕ) < r + k →
      ¬ (c ≤ (σ i : ℕ) ∧ (σ i : ℕ) < c + k)

abbrev greatestK : ℕ → ℕ := fun n ↦ Nat.sqrt (n - 1)

theorem _root_.LeanGolf.compfiles.imo2014_p2 (n : ℕ) (hn : 2 ≤ n) :
    IsGreatest {k : ℕ | ∀ σ : Equiv.Perm (Fin n), HasEmptySquare σ k} (greatestK n) := by sorry
