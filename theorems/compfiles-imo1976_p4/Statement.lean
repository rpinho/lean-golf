import Mathlib.Tactic

noncomputable section

namespace Imo1976P4

def result : ℕ → ℕ
  | 0 => 1
  | 1 => 1
  | 2 => 2
  | 3 => 3
  | 4 => 4
  | n + 3 => 3 * (result n)

abbrev solution : ℕ := result 1976

theorem _root_.LeanGolf.compfiles.imo1976_p4 :
    IsGreatest
      { n | ∃ s : Multiset ℕ, s.sum = 1976 ∧ s.prod = n }
      solution := by sorry
