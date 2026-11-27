import Mathlib

namespace Imo2009P1

theorem _root_.LeanGolf.compfiles.imo2009_p1 (n k : ℕ) (_hn : 0 < n) (hk : 2 ≤ k)
    (a : Fin k → ℤ)
    (hmem : ∀ i, a i ∈ Finset.Icc 1 (n : ℤ))
    (hdistinct : Function.Injective a)
    (hdvd : ∀ i : Fin k, (hi : (i : ℕ) + 1 < k) →
              (n : ℤ) ∣ a i * (a ⟨(i : ℕ) + 1, hi⟩ - 1)) :
    ¬ (n : ℤ) ∣ a ⟨k - 1, by lia⟩ * (a ⟨0, by lia⟩ - 1) := by sorry
