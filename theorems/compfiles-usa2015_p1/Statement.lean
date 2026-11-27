import Mathlib.Tactic

noncomputable section

namespace Usa2015P1

abbrev SolutionSet : Set (ℤ × ℤ) :=
  {⟨x, y⟩ | ∃ n, x = n ^ 3 + 3 * n ^ 2 - 1 ∧ y = -n ^ 3 + 3 * n + 1} ∪
  {⟨x, y⟩ | ∃ n, y = n ^ 3 + 3 * n ^ 2 - 1 ∧ x = -n ^ 3 + 3 * n + 1}

theorem _root_.LeanGolf.compfiles.usa2015_p1 (x y : ℤ) :
    ⟨x, y⟩ ∈ SolutionSet ↔
    x^2 + x * y + y^2 = ((x + y) / (3 : ℚ) + 1)^3 := by sorry
