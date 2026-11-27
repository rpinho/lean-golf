import Mathlib.Data.Fintype.Card
import Mathlib.Data.Nat.ModEq
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

namespace Imo1986P1

theorem _root_.LeanGolf.compfiles.imo1986_p1 (d : ℤ) (_hdpos : 1 ≤ d) (h2 : d ≠ 2) (h5 : d ≠ 5) (h13 : d ≠ 13) :
    ∃ a b :({2, 5, 13, d} : Finset ℤ), (a ≠ b) ∧ ¬ ∃ z, z^2 = (a * (b : ℤ) - 1) := by sorry
