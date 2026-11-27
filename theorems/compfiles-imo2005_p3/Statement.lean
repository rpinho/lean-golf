import Mathlib
import Mathlib.Tactic

namespace Imo2005P3

theorem _root_.LeanGolf.compfiles.imo2005_p3 (x y z : ℝ) (hx : x > 0) (hy : y > 0) (hz : z > 0) (h : x * y * z ≥ 1) :
    (x ^ 5 - x ^ 2) / (x ^ 5 + y ^ 2 + z ^ 2) + (y ^ 5 - y ^ 2) / (y ^ 5 + z ^ 2 + x ^ 2) +
        (z ^ 5 - z ^ 2) / (z ^ 5 + x ^ 2 + y ^ 2) ≥
      0 := by sorry
