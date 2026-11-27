import Mathlib.Tactic

noncomputable section

namespace Imo1970P2

def value (x : ℕ → ℕ) (c : ℕ) (m : ℕ) : ℝ :=
  ∑ i ∈ Finset.range (m + 1), (x i : ℝ) * (c : ℝ) ^ i

theorem _root_.LeanGolf.compfiles.imo1970_p2 (a b n : ℕ) (ha : 1 < a) (hb : 1 < b) (hn : 1 < n) (x : ℕ → ℕ)
    (hdig : ∀ i ≤ n, x i < min a b) (hxn : x n ≠ 0) (hxn1 : x (n - 1) ≠ 0) :
    value x a (n - 1) / value x a n < value x b (n - 1) / value x b n ↔ b < a := by sorry
