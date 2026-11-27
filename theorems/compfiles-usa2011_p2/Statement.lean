import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa2011P2

abbrev Config := ZMod 5 → ℤ

def Reachable (a b : Config) : Prop :=
  ∃ x : ZMod 5 → ℤ, ∀ i, b i = a i + 2 * x i - x (i + 2) - x (i + 3)

def WinAt (a : Config) (v : ZMod 5) : Prop :=
  Reachable a (Pi.single v 2011)

theorem _root_.LeanGolf.compfiles.usa2011_p2 (a : Config) (hsum : ∑ i, a i = 2011) :
    ∃! v, WinAt a v := by sorry
