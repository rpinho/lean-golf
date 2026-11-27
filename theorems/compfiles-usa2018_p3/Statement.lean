import Mathlib.Algebra.Order.Star.Basic
import Mathlib.Data.Nat.Choose.Sum
import Mathlib.Data.Nat.Totient
import Mathlib.NumberTheory.Padics.PadicVal.Basic

namespace Usa2018P3

theorem _root_.LeanGolf.compfiles.usa2018_p3 (n : ℕ) (hn : 2 ≤ n) (k : ℕ) (_hk : 1 ≤ k)
    (h : ∀ p : ℕ, p.Prime → p ∣ n.totient → p ∣ n) :
    n.totient ∣ ∑ a ∈ (Finset.range n).filter (Nat.Coprime n), a ^ k := by sorry
