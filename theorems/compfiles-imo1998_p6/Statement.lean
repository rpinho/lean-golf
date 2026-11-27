import Mathlib

noncomputable section

namespace Imo1998P6

abbrev answer : ℕ+ := 120

theorem _root_.LeanGolf.compfiles.imo1998_p6 :
    IsLeast
      {k : ℕ+ | ∃ f : ℕ+ → ℕ+, (∀ m n : ℕ+, f (n ^ 2 * f m) = m * f n ^ 2) ∧ f 1998 = k}
      answer := by sorry
