import Mathlib.Data.Nat.Digits.Lemmas
import Mathlib.Tactic

namespace ZerosOnesAndTwos

theorem _root_.LeanGolf.compfiles.ones_and_twos
    (n : ℕ) : ∃ k : ℕ+, ∀ e ∈ Nat.digits 10 (2^n * k), e = 1 ∨ e = 2 := by sorry
