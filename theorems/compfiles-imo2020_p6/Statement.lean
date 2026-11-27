import Mathlib

namespace Imo2020P6

open Finset Module

open scoped RealInnerProductSpace

variable {V P : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [MetricSpace P]

variable [NormedAddTorsor V P] (dim : Nat) [Fact (finrank ℝ V = dim + 1)]

variable [Fact (Module.finrank ℝ V = 2)]

theorem _root_.LeanGolf.compfiles.imo2020_p6 : ∃ c : ℝ, 0 < c ∧ ∀ {n : ℕ}, 1 < n → ∀ {S : Finset P}, #S = n →
    ((S : Set P).Pairwise fun x y ↦ 1 ≤ dist x y) →
    ∃ l : AffineSubspace ℝ P, finrank ℝ l.direction = 1 ∧
      (∃ p₁ ∈ S, ∃ p₂ ∈ S, l.SOppSide p₁ p₂) ∧
      ∀ p ∈ S, c * (n : ℝ) ^ (-1 / 3 : ℝ) ≤ Metric.infDist p l := by sorry
