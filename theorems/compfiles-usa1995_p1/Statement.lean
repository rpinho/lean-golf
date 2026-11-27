import Mathlib.Algebra.Field.ZMod
import Mathlib.Data.List.GetD
import Mathlib.NumberTheory.Padics.PadicVal.Basic

noncomputable section

namespace Usa1995P1

def HasAp (a : ℕ → ℕ) (p n m : ℕ) : Prop :=
  ∃ v : Fin p → ℕ, StrictMono v ∧ (∀ i, v i ≤ n) ∧
    ∃ x d : ℕ, ∀ i : Fin p, (v i < n → a (v i) = x + i.val * d) ∧
      (v i = n → m = x + i.val * d)

theorem _root_.LeanGolf.compfiles.usa1995_p1 (p : ℕ) (hp : p.Prime) (ho : Odd p) (a : ℕ → ℕ)
    (ha₀ : ∀ n < p - 1, a n = n)
    (ha₁ : ∀ n ≥ p - 1, IsLeast {m | a (n - 1) < m ∧ ¬ HasAp a p n m} (a n)) :
    ∀ n, a n = Nat.ofDigits p (Nat.digits (p - 1) n) := by sorry
