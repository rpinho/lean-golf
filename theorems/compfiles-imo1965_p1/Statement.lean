import Mathlib.Tactic

noncomputable section

namespace Imo1965P1

open Real Set

noncomputable abbrev the_answer : Set ℝ := Icc (π/4) (7*π/4)

theorem _root_.LeanGolf.compfiles.imo1965_p1 :
    {x ∈ Icc 0 (2*π) |
       |√(1 + sin (2*x)) - √(1 - sin (2*x))| ∈ Icc (2 * cos x) √2}
     = the_answer := by sorry
