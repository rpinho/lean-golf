import Mathlib.Algebra.Ring.Basic
import Mathlib.Tactic.Ring

noncomputable section

namespace Bulgaria1998P8

variable {R : Type} [CommRing R]

def P : ℕ → R → R → R
| 0, _, _ => 1
| n+1, x, y => (x + y - 1) * (y + 1) * P n x (y + 2) + (y - y^2) * P n x y

theorem _root_.LeanGolf.compfiles.bulgaria1998_p8 (n : ℕ) (x y : R) : P n x y = P n y x := by sorry
