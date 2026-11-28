import Mathlib.Tactic

noncomputable section

namespace Imo1984P2

abbrev a : ℤ := 18

abbrev b : ℤ := 1

theorem _root_.LeanGolf.minif2f.imo_1984_p2 :
    (0 < a) ∧ (0 < b) ∧
    (¬ 7 ∣ a * b * (a + b)) ∧
    7^7 ∣ (a + b)^7 - a^7 - b^7 := by sorry
