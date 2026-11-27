import Mathlib

noncomputable section

open Real

namespace Singapore2019R1P4

noncomputable abbrev solution (x : ℝ) : ℝ := 2*x / (1-x)

theorem _root_.LeanGolf.compfiles.singapore2019_r1_p4 (x : ℝ) (hx : Real.logb 21 3 = x) :
    Real.logb 7 9 = solution x := by sorry
