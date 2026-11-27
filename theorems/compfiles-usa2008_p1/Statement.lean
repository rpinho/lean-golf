import Mathlib.Tactic

namespace Usa2008P1

theorem _root_.LeanGolf.compfiles.usa2008_p1 (n : ℕ) (_hn : 0 < n) :
    ∃ k : Fin (n + 1) → ℕ,
      (∀ i, 1 < k i) ∧
      (∀ i j, i ≠ j → Nat.Coprime (k i) (k j)) ∧
      ∃ m, ∏ i : Fin (n + 1), k i = 1 + m * (m + 1) := by sorry
