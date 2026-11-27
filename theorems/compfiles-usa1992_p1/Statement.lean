import Mathlib.Data.Nat.Digits.Lemmas
import Mathlib.Tactic

noncomputable section

namespace Usa1992P1

abbrev solution : ℕ → ℕ := fun n ↦ 9 * 2 ^ n

theorem _root_.LeanGolf.compfiles.usa1992_p1 (n : ℕ) :
    (Nat.digits 10
     (∏ i ∈ Finset.range (n + 1), (10^(2^i) - 1))).sum = solution n := by sorry
