import Mathlib.Data.Nat.Digits.Lemmas
import Mathlib.Tactic

noncomputable section

namespace Imo1968P2

abbrev solution_set : Set ℕ := { 12 }

theorem _root_.LeanGolf.compfiles.imo1968_p2 (x : ℕ) :
    x ∈ solution_set ↔
    x^2 = 10 * x + 22 + (Nat.digits 10 x).prod := by sorry
