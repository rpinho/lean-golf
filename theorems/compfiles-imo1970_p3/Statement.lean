import Mathlib.Tactic

noncomputable section

namespace Imo1970P3

open scoped Real

structure IncreasingSequenceFromOne where
  a : ℕ → ℝ
  a_zero : a 0 = 1
  a_mono : Monotone a

noncomputable def b_seq (seq : IncreasingSequenceFromOne) (n : ℕ) : ℝ :=
  ∑ k ∈ Finset.range n, (1 - seq.a k / seq.a (k + 1)) / √ (seq.a (k + 1))

def ValidBounds : Set ℝ :=
  { b | 0 ≤ b ∧ b < 2 }

theorem _root_.LeanGolf.compfiles.imo1970_p3 :
    (∀ seq : IncreasingSequenceFromOne, ∀ n : ℕ, b_seq seq n ∈ ValidBounds) ∧
    (∀ c ∈ ValidBounds, ∃ seq : IncreasingSequenceFromOne, ∃ N : ℕ,
      ∀ n ≥ N, c < b_seq seq n) := by sorry
