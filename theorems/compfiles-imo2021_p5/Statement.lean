import Mathlib.Algebra.Field.ZMod
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Tactic.Cases

noncomputable section

namespace Imo2021P5

abbrev Position : Type := Fin 2021 ≃ Fin 2021

def Position.swapped (p : Position) (k : Fin 2021) : Fin 2021 × Fin 2021 :=
  (p ((p.symm k) - 1), p ((p.symm k) + 1))

def move (p : Position × Fin 2021) : Position × Fin 2021 :=
  (p.1.trans (Equiv.swap (p.1.swapped p.2).1 (p.1.swapped p.2).2), p.2 + 1)

def Position.nth (p : Position) (n : Fin 2021) : Position := (move^[n] (p, 0)).1

theorem _root_.LeanGolf.compfiles.imo2021_p5 (p : Position) :
    ∃ k, (((p.nth k).swapped k).1 < k ∧ k < ((p.nth k).swapped k).2) ∨
      (((p.nth k).swapped k).2 < k ∧ k < ((p.nth k).swapped k).1) := by sorry
