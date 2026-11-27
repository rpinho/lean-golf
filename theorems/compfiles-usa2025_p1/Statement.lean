import Mathlib.Data.List.GetD
import Mathlib.Data.Nat.Digits.Lemmas

namespace Usa2025P1

theorem _root_.LeanGolf.compfiles.usa2025_p1 (k d : ℕ) (hk : 0 < k) (_hd : 0 < d) :
    ∃ N : ℕ, ∀ n : ℕ, N ≤ n → Odd n → ∀ a ∈ Nat.digits (2 * n) (n ^ k), d < a := by sorry
