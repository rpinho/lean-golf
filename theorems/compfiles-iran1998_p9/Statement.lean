import Mathlib
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Analysis.Normed.Lp.PiLp

namespace Iran1998P9

theorem _root_.LeanGolf.compfiles.iran1998_p9
    (x y z : ℝ)
    (hx : 1 < x)
    (hy : 1 < y)
    (hz : 1 < z)
    (h : 1/x + 1/y + 1/z = 2) :
    √(x - 1) + √(y - 1) + √(z - 1) ≤ √(x + y + z) := by sorry
