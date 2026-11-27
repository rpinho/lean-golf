import Mathlib.Tactic

noncomputable section

namespace Imo1977P5

abbrev solution_set : Set (ℕ×ℕ) := {(7,50), (37, 50), (50, 7), (50, 37)}

theorem _root_.LeanGolf.compfiles.imo1977_p5
    (a b q r : ℕ)
    (hp: 0 < a ∧ 0 < b)
    (h₀ : r = (a ^ 2 + b ^ 2) % (a + b))
    (h₁ : q = (a ^ 2 + b ^ 2) / (a + b)) :
    q ^ 2 + r = 1977 ↔ (a, b) ∈ solution_set := by sorry
