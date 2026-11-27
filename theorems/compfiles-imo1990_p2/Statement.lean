import Mathlib.Tactic

noncomputable section

namespace Imo1990P2

abbrev solution (n : ℕ) : ℕ := if n % 3 = 2 then n - 1 else n

def IsGood (n : ℕ) (B : Finset (ZMod (2 * n - 1))) : Prop :=
  ∃ x ∈ B, ∃ y ∈ B, y - x = ((n + 1 : ℕ) : ZMod (2 * n - 1)) ∨
    x - y = ((n + 1 : ℕ) : ZMod (2 * n - 1))

theorem _root_.LeanGolf.compfiles.imo1990_p2 (n : ℕ) (hn : 3 ≤ n) :
    IsLeast {k : ℕ | ∀ B : Finset (ZMod (2 * n - 1)), B.card = k → IsGood n B}
      (solution n) := by sorry
