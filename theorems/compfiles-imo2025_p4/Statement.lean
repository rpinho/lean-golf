import Mathlib

noncomputable section

namespace Imo2025P4

open Finset

abbrev answer : Set ℕ := { x | ∃ e l : ℕ, x = 12^e * 6 * l ∧ l.Coprime 10 }

variable {a₁ : ℕ} {a : ℕ → ℕ} {x d d₁ d₂ d₃ : ℕ}

theorem _root_.LeanGolf.compfiles.imo2025_p4 : {a₁ | ∃ a : ℕ → ℕ, a 0 = a₁ ∧ ∀ i, 0 < a i ∧ 3 ≤ #(Nat.properDivisors (a i)) ∧
    a (i + 1) = (((Nat.properDivisors (a i)).sort (· ≤ ·)).reverse.take 3).sum} = answer := by sorry
