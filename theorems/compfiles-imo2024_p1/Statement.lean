import Mathlib.Algebra.Order.BigOperators.Group.LocallyFinite
import Mathlib.Tactic

noncomputable section

namespace Imo2024P1

abbrev solutionSet : Set ℝ := {α : ℝ | ∃ m : ℤ, α = 2 * m}

theorem _root_.LeanGolf.compfiles.imo2024_p1 (α : ℝ) :
  α ∈ solutionSet ↔
  ∀ n : ℕ, 0 < n → (n : ℤ) ∣ ∑ i ∈ Finset.Icc 1 n, ⌊i * α⌋ := by sorry
