import Mathlib.Data.Nat.Digits.Lemmas
import Mathlib.Tactic

namespace ZerosOnesAndTwos

theorem _root_.LeanGolf.compfiles.zeroes_and_ones
    (n : ℕ) : ∃ k : ℕ+, ∀ e ∈ Nat.digits 10 (n * k), e = 0 ∨ e = 1 := by sorry
