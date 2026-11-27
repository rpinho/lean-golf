import Mathlib

noncomputable section

namespace Imo1993P5

abbrev DoesExist : Bool := True

abbrev Good (f : ℕ → ℕ) : Prop := f 1 = 2 ∧ ∀ n, f (f n) = f n + n ∧ ∀ n, f n < f (n + 1)

theorem _root_.LeanGolf.compfiles.imo1993_p5 : DoesExist ↔ ∃ f, Good f  := by sorry
