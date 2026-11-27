import Mathlib.Tactic

namespace Usa2010P5

open Finset

theorem _root_.LeanGolf.compfiles.usa2010_p5 (p q : ℕ) (hpp : Nat.Prime p) (hpo : Odd p) (hq : q = (3*p-5)/2) :
    ∀ (m n : ℤ), n ≠ 0 →
      (1 : ℚ)/p - 2 * (∑ k ∈ (Finset.Icc 2 q).filter (fun k ↦ k % 3 = 2),
        (1 : ℚ)/(k*(k+1)*(k+2))) = (m : ℚ)/(n : ℚ) →
      (p : ℤ) ∣ (m - n) := by sorry
