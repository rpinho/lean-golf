import Mathlib.Algebra.BigOperators.Fin
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Data.ZMod.Defs
import Mathlib.InformationTheory.Hamming

noncomputable section

namespace Usa1990P1

abbrev Plate := Fin 6 → ZMod 10

def IsValid (S : Finset Plate) : Prop :=
  ∀ p ∈ S, ∀ q ∈ S, p ≠ q → 2 ≤ hammingDist p q

abbrev answer : ℕ := 10 ^ 5

theorem _root_.LeanGolf.compfiles.usa1990_p1 :
    IsGreatest {k : ℕ | ∃ S : Finset Plate, S.card = k ∧ IsValid S} answer := by sorry
