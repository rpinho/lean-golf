import Mathlib

noncomputable section

namespace Imo1997P4

def SilverMatrix (n : ℕ) (M : Fin n → Fin n → ℕ) : Prop :=
  (∀ i j, M i j ∈ Finset.Icc 1 (2 * n - 1)) ∧
  (∀ i, (Finset.univ.image (fun j ↦ M i j) ∪ Finset.univ.image (fun j ↦ M j i))
          = Finset.Icc 1 (2 * n - 1))

open Finset

theorem _root_.LeanGolf.compfiles.imo1997_p4 :
    (¬ ∃ M : Fin 1997 → Fin 1997 → ℕ, SilverMatrix 1997 M) ∧
    {n : ℕ | ∃ M : Fin n → Fin n → ℕ, SilverMatrix n M}.Infinite := by sorry
