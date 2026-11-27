import Mathlib

noncomputable section

namespace Imo2016P4

abbrev Fragrant (s : Set ℕ+) : Prop :=
  2 ≤ s.ncard ∧ ∀ m ∈ s, ∃ n ∈ s, n ≠ m ∧ ¬Nat.Coprime m n

abbrev P (n : ℕ) : ℕ := n^2 + n + 1

abbrev Solution : ℕ+ := 6

theorem _root_.LeanGolf.compfiles.imo2016_p4 :
    IsLeast
      {b : ℕ+ | ∃ a : ℕ, Fragrant {p | ∃ i : ℕ+, i ≤ b ∧ p = P (a + i)}}
      Solution := by sorry
