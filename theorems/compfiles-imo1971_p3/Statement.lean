import Mathlib.Tactic

namespace Imo1971P3

theorem _root_.LeanGolf.compfiles.imo1971_p3 :
   ∃ s : Set ℕ+,
     s.Infinite ∧
     s.Pairwise fun m n ↦ Nat.Coprime (2 ^ n.val - 3) (2 ^ m.val - 3) := by sorry
