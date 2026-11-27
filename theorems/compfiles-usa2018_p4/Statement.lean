import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Field.ZMod
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.LinearCombination.Lemmas
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Ring.Basic

namespace Usa2018P4

open Finset

variable {p : ℕ}

variable (a : Fin p → ZMod p)

theorem _root_.LeanGolf.compfiles.usa2018_p4 (p : ℕ) (hp : p.Prime) (a : Fin p → ℤ) :
    ∃ k : ℤ, p ≤ 2 * (Finset.univ.image fun i : Fin p ↦
      (a i : ZMod p) + ((i : ℕ) : ZMod p) * (k : ZMod p)).card := by sorry
