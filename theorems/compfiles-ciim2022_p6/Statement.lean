import Mathlib.Tactic

noncomputable section

namespace CIIM2022P6

def d : ℕ → ℕ
| m => (Nat.divisors m).card

theorem _root_.LeanGolf.compfiles.ciim2022_p6 (n : ℕ) (hn : 0 < n) :
    d (Nat.factorial (n + 1)) ≤ 2 * d (Nat.factorial n) := by sorry
