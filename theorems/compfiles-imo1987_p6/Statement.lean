import Mathlib.Data.Nat.Prime.Basic
import Mathlib
import Mathlib.Tactic.Ring

namespace Imo1987P6

open Nat

theorem _root_.LeanGolf.compfiles.imo1987_p6
    (p : ℕ)
    (h₁ : ∀ k : ℕ, k ≤ Nat.floor (Real.sqrt ((p:ℝ) / 3)) → Nat.Prime (k^2 + k + p)) :
    ∀ i ≤ p - 2, Nat.Prime (i^2 + i + p) := by sorry
