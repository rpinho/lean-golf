import Mathlib.Tactic

noncomputable section

namespace Imo2017P1

abbrev solution_set : Set ℕ := {x | 0 < x ∧ 3 ∣ x}

variable {a : ℕ → ℕ → ℕ} {x : ℕ}

theorem _root_.LeanGolf.compfiles.imo2017_p1
    (a : ℕ → ℕ → ℕ)
    (ha₀: ∀ x, a x 0 = x)
    (ha₁: ∀ x i, 1 < x → if IsSquare (a x i)
                         then a x (i + 1) = Nat.sqrt (a x i)
                         else a x (i + 1) = a x i + 3) :
    ∀ x > 1, (∃ A, {n | a x n = A}.Infinite) ↔ x ∈ solution_set := by sorry
