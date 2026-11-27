import Mathlib.Tactic

noncomputable section

namespace Imo1978P1

abbrev solution : ℕ × ℕ := (3, 103)

abbrev ValidPair : ℕ × ℕ → Prop
| (m, n) => 1 ≤ m ∧ m < n ∧ (1978^m) % 1000 = (1978^n) % 1000

theorem _root_.LeanGolf.compfiles.imo1978_p1 (m n : ℕ)
    (hmn : (m, n) = solution) :
    ValidPair (m, n) ∧
    (∀ m' n' : ℕ, ValidPair (m', n') → m + n ≤ m' + n') := by sorry
