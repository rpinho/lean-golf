import Mathlib.AlgebraicTopology.SimplexCategory.Basic

noncomputable section

namespace Usa1996P4

def sget {n : ℕ} (x : Fin n → Bool) (i : ℕ) : Bool :=
  if h : i < n then x ⟨i, h⟩ else false

abbrev GoodA {n : ℕ} (x : Fin n → Bool) : Prop :=
  ∀ i : Fin n, (i : ℕ) + 2 < n →
    ¬(sget x (i : ℕ) = false ∧ sget x ((i : ℕ) + 1) = true ∧ sget x ((i : ℕ) + 2) = false)

abbrev GoodB {n : ℕ} (y : Fin n → Bool) : Prop :=
  ∀ i : Fin n, (i : ℕ) + 3 < n →
    ¬((sget y (i : ℕ) = false ∧ sget y ((i : ℕ) + 1) = false ∧ sget y ((i : ℕ) + 2) = true ∧
        sget y ((i : ℕ) + 3) = true) ∨
      (sget y (i : ℕ) = true ∧ sget y ((i : ℕ) + 1) = true ∧ sget y ((i : ℕ) + 2) = false ∧
        sget y ((i : ℕ) + 3) = false))

theorem _root_.LeanGolf.compfiles.usa1996_p4 (n : ℕ) :
    Fintype.card {y : Fin (n + 1) → Bool // GoodB y} =
      2 * Fintype.card {x : Fin n → Bool // GoodA x} := by sorry
