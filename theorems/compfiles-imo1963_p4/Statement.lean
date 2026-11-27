import Mathlib.Tactic

noncomputable section

namespace Imo1963P4

abbrev SolutionSet (y : ℝ) : Set (ℝ × ℝ × ℝ × ℝ × ℝ) :=
 {(x₁, x₂, x₃, x₄, x₅) |
  (x₁ = 0 ∧ x₂ = 0 ∧ x₃ = 0 ∧ x₄ = 0 ∧ x₅ = 0) ∨
  (x₁ = x₂ ∧ x₂ = x₃ ∧ x₃ = x₄ ∧ x₄ = x₅ ∧ y = 2) ∨
  (y^2 + y - 1 = 0 ∧ ∃ s t,
    x₁ = s ∧
    x₂ = t ∧
    x₃ = y * t - s ∧
    x₄ = -(y * t) - y * s ∧
    x₅ = y * s - t)}

theorem _root_.LeanGolf.compfiles.imo1963_p4 (x₁ x₂ x₃ x₄ x₅ y : ℝ) :
    (x₁, x₂, x₃, x₄, x₅) ∈ SolutionSet y ↔
    (x₅ + x₂ = y * x₁ ∧
     x₁ + x₃ = y * x₂ ∧
     x₂ + x₄ = y * x₃ ∧
     x₃ + x₅ = y * x₄ ∧
     x₄ + x₁ = y * x₅) := by sorry
