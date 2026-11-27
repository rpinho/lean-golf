import Mathlib.Tactic

noncomputable section

namespace Imo2018P2

abbrev P {n : ℕ} (a : ZMod n → ℝ) :=
  ∀ (i : ZMod n), a i * a (i + 1) + 1 = a (i + 2)

abbrev solution_set : Set ℕ := { n | 3 ≤ n ∧ 3 ∣ n }

theorem _root_.LeanGolf.compfiles.imo2018_p2 (n : ℕ) :
    n ∈ solution_set ↔ 3 ≤ n ∧ ∃ a : ZMod n → ℝ, P a := by sorry
