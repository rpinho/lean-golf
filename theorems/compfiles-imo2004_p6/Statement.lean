import Mathlib

noncomputable section

namespace Imo2004P6

abbrev SolutionSet : Set ℕ := {n | 0 < n ∧ ¬ 20 ∣ n}

abbrev Alternating (n : Nat) : Prop :=
  0 < n ∧ (Nat.digits 10 n).IsChain (fun k l ↦ ¬ k ≡ l [MOD 2])

theorem _root_.LeanGolf.compfiles.imo2004_p6 (n : ℕ) :
    n ∈ SolutionSet ↔ 0 < n ∧ ∃ k, Alternating (n * k) := by sorry
