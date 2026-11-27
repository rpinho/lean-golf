import Mathlib.Tactic

noncomputable section

namespace Usa1978P1

noncomputable abbrev max_e : ℝ := (16 : ℝ) / 5

abbrev IsGood (a b c d e : ℝ) : Prop :=
  a + b + c + d + e = 8 ∧ a^2 + b^2 + c^2 + d^2 + e^2 = 16

theorem _root_.LeanGolf.compfiles.usa1978_p1 :
    IsGreatest { e : ℝ | ∃ a b c d : ℝ, IsGood a b c d e } max_e := by sorry
