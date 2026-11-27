import Mathlib.Tactic
import Mathlib.Data.Nat.GCD.Basic

namespace Russia1995P10

theorem _root_.LeanGolf.compfiles.russia1995_p10 {m n : ℕ} (h₀ : n ≠ 0 ∧ m ≠ 0)
  (h : gcd m n + lcm m n = m + n) :
  m ∣ n ∨ n ∣ m := by sorry
