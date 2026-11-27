import Mathlib

noncomputable section

def b : ℕ → ℤ
| 0 => 0
| n + 1 => 2 * (b n) ^ 2 + b n + 1

theorem LeanGolf.putnambench.putnam_2025_a6 (k : ℕ) (hk : 1 ≤ k) :
    (2 ^ (2 * k + 2) : ℤ) ∣ (b (2 ^ (k + 1)) - 2 * b (2 ^ k)) ∧
    ¬((2 ^ (2 * k + 3) : ℤ) ∣ (b (2 ^ (k + 1)) - 2 * b (2 ^ k))) := by sorry
