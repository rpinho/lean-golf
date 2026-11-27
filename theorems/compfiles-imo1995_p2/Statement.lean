import Mathlib

namespace Imo1995P2

open Finset

theorem _root_.LeanGolf.compfiles.imo1995_p2 (a b c : ℝ) (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (habc : a * b * c = 1) :
    3 / 2 ≤ 1 / (a^3 * (b + c)) + 1 / (b^3 * (c + a)) + 1 / (c^3 * (a + b)) := by sorry
