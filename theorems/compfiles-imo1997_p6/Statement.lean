import Mathlib.Tactic

noncomputable section

namespace Imo1997P6

def f : ℕ → ℕ
  | 0 => 1
  | n + 1 => f n + if (n + 1) % 2 = 0 then f ((n + 1) / 2) else 0
termination_by n => n
decreasing_by all_goals lia

theorem _root_.LeanGolf.compfiles.imo1997_p6 (n : ℕ) (hn : 3 ≤ n) :
    (2 : ℝ) ^ ((n : ℝ) ^ 2 / 4) < (f (2 ^ n) : ℝ) ∧
      (f (2 ^ n) : ℝ) < (2 : ℝ) ^ ((n : ℝ) ^ 2 / 2) := by sorry
