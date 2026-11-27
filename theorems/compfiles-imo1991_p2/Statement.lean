import Mathlib

namespace Imo1991P2

theorem _root_.LeanGolf.compfiles.imo1991_p2 (n : ℕ) (hn : 6 < n)
    (k : ℕ) (a : Fin k → ℕ)
    (ha1 : { a i | i } = { m | Nat.Coprime m n ∧ m < n })
    (d : ℕ) (hd : 0 < d)
    (ha2 : ∀ i : Fin k, (h : i + 1 < k) → a i + d = a ⟨i + 1, h⟩) :
    n.Prime ∨ n.isPowerOfTwo := by sorry
