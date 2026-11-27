import Mathlib

noncomputable section

namespace Imo1978P6

variable {M N : ℕ}

abbrev Name : Type := Finset.Icc 1 M

variable (C : @Name M → Fin N)

theorem _root_.LeanGolf.compfiles.imo1978_p6 (C : Finset.Icc 1 1978 → Fin 6) :
  ∃ j i k, C i = C j ∧ C j = C k ∧ i.val + k.val = j.val := by sorry
