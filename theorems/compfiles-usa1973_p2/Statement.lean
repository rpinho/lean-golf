import Mathlib.Tactic
import Mathlib.Data.Nat.Basic

noncomputable section

namespace Usa1973P2

def a : ℕ → ℕ
| 0 => 1
| 1 => 1
| n + 2 => a (n + 1) + 2 * a n

def b : ℕ → ℕ
| 0 => 1
| 1 => 7
| n + 2 => 2 * b (n + 1) + 3 * b n

theorem _root_.LeanGolf.compfiles.usa1973_p2 (n m : ℕ) (h : a n = b m): a n = 1 := by sorry
