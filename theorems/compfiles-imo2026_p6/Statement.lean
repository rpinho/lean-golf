import Mathlib.Data.Nat.Squarefree

noncomputable section

namespace Imo2026P6

def IsValidSeq (a : ℕ → ℕ) : Prop :=
  (∀ n, 1 < a n) ∧
  (∀ n, a n < a (n + 1) ∧
        (∀ i ≤ n, 1 < Nat.gcd (a (n + 1)) (a i)) ∧
        (∀ b, a n < b → b < a (n + 1) → ∃ i ≤ n, Nat.gcd b (a i) = 1))

theorem _root_.LeanGolf.compfiles.imo2026_p6 (a : ℕ → ℕ) (ha : IsValidSeq a) :
    ∃ T L : ℕ, 0 < T ∧ 0 < L ∧ ∀ n, a (n + T) = a n + L := by sorry
