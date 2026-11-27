import Mathlib.Tactic

noncomputable section

namespace Imo1996P4

abbrev solution : ℤ := 231361

def S := { l | ∃ a b m n : ℤ,
    0 < a ∧ 0 < b ∧ 0 < m ∧ 0 < n ∧
    15*a + 16*b = m^2 ∧
    16*a - 15*b = n^2 ∧
    l = min (m^2) (n^2) }

theorem _root_.LeanGolf.compfiles.imo1996_p4 : solution ∈ S ∧ ∀ x ∈ S, solution ≤ x := by sorry
