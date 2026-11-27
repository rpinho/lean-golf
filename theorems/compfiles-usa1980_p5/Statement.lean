import Mathlib.Tactic

namespace Usa1980P5

theorem _root_.LeanGolf.compfiles.usa1980_p5 (x y z : ℝ)
    (hx : x ∈ Set.Icc 0 1)
    (hy : y ∈ Set.Icc 0 1)
    (hz : z ∈ Set.Icc 0 1) :
    x / (y + z + 1) + y / (z + x + 1) + z / (x + y + 1) ≤
    1 + (1 - x) * (1 - y) * (1 - z) := by sorry
