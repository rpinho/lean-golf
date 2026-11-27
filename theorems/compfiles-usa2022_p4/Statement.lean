import Mathlib.Tactic

noncomputable section

namespace Usa2022P4

abbrev solution_set : Set (ℕ × ℕ) := {(3, 2)}

theorem _root_.LeanGolf.compfiles.usa2022_p4 (p q : ℕ) :
    (p, q) ∈ solution_set ↔
    p.Prime ∧ q.Prime ∧
    ∃ a, a^2 + q = p ∧ ∃ b, b^2 + q = p * q := by sorry
