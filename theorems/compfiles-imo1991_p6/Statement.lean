import Mathlib.Tactic

noncomputable section

namespace Imo1991P6

abbrev Bounded (x : ℕ → ℝ) : Prop := ∃ C, ∀ i, |x i| ≤ C

noncomputable abbrev solution (a : ℝ) (ha : 1 < a) : ℕ → ℝ :=
  fun n => (2*√2 + 2) * Int.fract (√2 * n)

theorem _root_.LeanGolf.compfiles.imo1991_p6 (a : ℝ) (ha : 1 < a) :
    Bounded (solution a ha) ∧
    ∀ i j, i ≠ j →
      1 ≤ |solution a ha i - solution a ha j| * |(i:ℝ) - j|^a := by sorry
