import Mathlib

noncomputable section

namespace Imo2012P6

abbrev solution_set : Set ℕ := { n : ℕ | n % 4 = 1 ∨ n % 4 = 2 }

def IsSolution (n : ℕ) : Prop := ∃ a : ℕ → ℕ, 0 < n ∧
  (∑ i ∈ Finset.Icc 1 n, (1 : ℚ) / (2 ^ a i)) = 1 ∧
  (∑ i ∈ Finset.Icc 1 n, (i : ℚ) / (3 ^ a i)) = 1

theorem _root_.LeanGolf.compfiles.imo2012_p6 : { n | IsSolution n } = solution_set := by sorry
