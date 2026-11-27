import Mathlib.AlgebraicTopology.SimplexCategory.Basic

noncomputable section

namespace Usa1978P5

abbrev Share {L : Type*} (speaks : Fin 9 → Finset L) (a b : Fin 9) : Prop :=
  ∃ l : L, l ∈ speaks a ∧ l ∈ speaks b

open Classical

theorem _root_.LeanGolf.compfiles.usa1978_p5 {L : Type*} (speaks : Fin 9 → Finset L)
    (hthree : ∀ d : Fin 9, (speaks d).card ≤ 3)
    (hpair : ∀ a b c : Fin 9, a ≠ b → a ≠ c → b ≠ c →
      Share speaks a b ∨ Share speaks b c ∨ Share speaks a c) :
    ∃ a b c : Fin 9, a ≠ b ∧ a ≠ c ∧ b ≠ c ∧
      ∃ l : L, l ∈ speaks a ∧ l ∈ speaks b ∧ l ∈ speaks c := by sorry
