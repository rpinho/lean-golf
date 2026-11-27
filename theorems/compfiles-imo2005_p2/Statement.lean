import Mathlib.Tactic

namespace Imo2005P2

theorem _root_.LeanGolf.compfiles.imo2005_p2 (a : ℕ → ℤ)
  (pos_inf : Set.Infinite {i | 0 < a i})
  (neg_inf : Set.Infinite {i | a i < 0})
  (rem : ∀ n > 0, ((Finset.range n).image (fun i => a i % n)).card = n)
    : ∀ z : ℤ, ∃! i, a i = z := by sorry
