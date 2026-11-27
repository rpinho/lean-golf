import Mathlib.Tactic

noncomputable section

namespace Bulgaria1998P1

abbrev coloring_is_good {m : ℕ} (color : Set.Icc 1 m → Fin 2) : Prop :=
  ∃ i j : Set.Icc 1 m,
    i < j ∧
    ∃ h3 : 2 * j.val - i ∈ Set.Icc 1 m,
    color i = color j ∧ color i = color ⟨2 * j - i, h3⟩

abbrev all_colorings_are_good (m : ℕ) : Prop :=
  3 ≤ m ∧ ∀ color : Set.Icc 1 m → Fin 2, coloring_is_good color

abbrev solution_value : ℕ := 9

theorem _root_.LeanGolf.compfiles.bulgaria1998_p1 : IsLeast { m | all_colorings_are_good m } solution_value := by sorry
