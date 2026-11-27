import Mathlib.Tactic

namespace Imo1979P1

theorem _root_.LeanGolf.compfiles.imo1979_p1 (p q : ℤ) (hp : 0 < p) (hq : 0 < q)
    (h : (p : ℚ) / q = ∑ i ∈ Finset.range 1319, (-1 : ℚ)^i / (i + 1)) :
    1979 ∣ p := by sorry
