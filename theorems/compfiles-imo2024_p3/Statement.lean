import Mathlib.Tactic
import Mathlib.Data.Set.Card
import Mathlib.Data.Nat.Nth

noncomputable section

namespace Imo2024P3

open scoped Finset

def Condition (a : ℕ → ℕ) (N : ℕ) : Prop :=
  (∀ i, 0 < a i) ∧ ∀ n, N < n → a n = #{i ∈ Finset.range n | a i = a (n - 1)}

def EventuallyPeriodic (b : ℕ → ℕ) : Prop :=
  ∃ p M, 0 < p ∧ ∀ m, M ≤ m → b (m + p) = b m

theorem _root_.LeanGolf.compfiles.imo2024_p3 {a : ℕ → ℕ} {N : ℕ} (h : Condition a N) :
    EventuallyPeriodic (fun i ↦ a (2 * i)) ∨ EventuallyPeriodic (fun i ↦ a (2 * i + 1)) := by sorry
