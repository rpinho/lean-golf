import Mathlib.Algebra.Order.Ring.Canonical
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Data.Int.NatAbs
import Mathlib.Data.Nat.ModEq

noncomputable section

namespace Imo1985P2

def Condition (n j : ℕ) (C : ℕ → Fin 2) : Prop :=
  (∀ i ∈ Set.Ico 1 n, C i = C (n - i)) ∧
  ∀ i ∈ Set.Ico 1 n, i ≠ j → C i = C (j - i : ℤ).natAbs

theorem _root_.LeanGolf.compfiles.imo1985_p2 {n j : ℕ} (hn : 3 ≤ n) (hj : j ∈ Set.Ico 1 n)
    (cpj : Nat.Coprime n j) {C : ℕ → Fin 2} (hC : Condition n j C)
    {i : ℕ} (hi : i ∈ Set.Ico 1 n) :
    C i = C j := by sorry
