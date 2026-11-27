import Mathlib
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.NumberTheory.PrimesCongruentOne
import Mathlib.NumberTheory.LegendreSymbol.QuadraticReciprocity
import Mathlib.Tactic.LinearCombination

open Real

namespace Imo2008P3

theorem _root_.LeanGolf.compfiles.imo2008_p3 : ∀ N : ℕ, ∃ n : ℕ, n ≥ N ∧
    ∃ p : ℕ, Nat.Prime p ∧ p ∣ n ^ 2 + 1 ∧ (p : ℝ) > 2 * n + sqrt (2 * n) := by sorry
