import Mathlib.FieldTheory.Finite.Basic

noncomputable section

namespace Imo2005P4

def a (n : ℕ) : ℤ := 2 ^ n + 3 ^ n + 6 ^ n - 1

abbrev SolutionSet : Set ℕ+ := { 1 }

theorem _root_.LeanGolf.compfiles.imo2005_p4 {k : ℕ} (hk : 0 < k) :
    (∀ n : ℕ, 1 ≤ n → IsCoprime (a n) k) ↔ ⟨k, hk⟩ ∈ SolutionSet := by sorry
