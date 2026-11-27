import Mathlib

noncomputable section

namespace Imo2013P2

abbrev Pt := EuclideanSpace ℝ (Fin 2)

structure ColombianConfiguration where
  red : Finset Pt
  blue : Finset Pt
  red_card : red.card = 2013
  blue_card : blue.card = 2014
  red_blue_disjoint : Disjoint red blue
  not_collinear : ∀ p₁ ∈ red ∪ blue, ∀ p₂ ∈ red ∪ blue, ∀ p₃ ∈ red ∪ blue,
    p₁ ≠ p₂ → p₁ ≠ p₃ → p₂ ≠ p₃ → ¬ Collinear ℝ {p₁, p₂, p₃}

def GoodArrangement (cfg : ColombianConfiguration) {k : ℕ}
    (lines : Fin k → AffineSubspace ℝ Pt) : Prop :=
  (∀ i, Module.finrank ℝ (lines i).direction = 1) ∧
  (∀ i, ∀ p ∈ cfg.red ∪ cfg.blue, p ∉ lines i) ∧
  (∀ p ∈ cfg.red, ∀ q ∈ cfg.blue, ∃ i, (lines i).SOppSide p q)

open scoped RealInnerProductSpace

abbrev solution_value : ℕ := 2013

theorem _root_.LeanGolf.compfiles.imo2013_p2 :
    IsLeast {k | ∀ cfg : ColombianConfiguration,
                 ∃ lines : Fin k → AffineSubspace ℝ Pt, GoodArrangement cfg lines}
            solution_value := by sorry
