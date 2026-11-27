import Mathlib

noncomputable section

namespace Imo2002P3

abbrev solution : Set (ℕ × ℕ) := {⟨5, 3⟩}

theorem _root_.LeanGolf.compfiles.imo2002_p3 {m n : ℕ} (hm : 3 ≤ m) (hn : 3 ≤ n) :
    ⟨m, n⟩ ∈ solution ↔
    {a : ℤ | 0 < a ∧ a ^ n + a ^ 2 - 1 ∣ a ^ m + a - 1}.Infinite := by sorry
