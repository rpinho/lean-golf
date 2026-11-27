import Mathlib

namespace Imo1961P4

open Set Affine EuclideanGeometry Module

variable {V Pt : Type*}

variable [NormedAddCommGroup V]

variable [InnerProductSpace ℝ V]

variable [MetricSpace Pt]

variable [NormedAddTorsor V Pt]

variable [Fact (finrank ℝ V = 2)]

theorem _root_.LeanGolf.compfiles.imo1961_p4
    (T : Affine.Triangle ℝ Pt)
    (P : Pt)
    (h_interior : P ∈ T.interior) :
    ∃ Q₁ Q₂ Q₃ : Pt,
      Wbtw ℝ (T.points 1) Q₁ (T.points 2) ∧
      Wbtw ℝ (T.points 2) Q₂ (T.points 0) ∧
      Wbtw ℝ (T.points 0) Q₃ (T.points 1) ∧
      Q₁ ∈ affineSpan ℝ ({P, T.points 0} : Set Pt) ∧
      Q₂ ∈ affineSpan ℝ ({P, T.points 1} : Set Pt) ∧
      Q₃ ∈ affineSpan ℝ ({P, T.points 2} : Set Pt) ∧
      P ≠ Q₁ ∧
      P ≠ Q₂ ∧
      P ≠ Q₃ ∧
      (dist P (T.points 0) / dist P Q₁ ≤ 2 ∨
        dist P (T.points 1) / dist P Q₂ ≤ 2 ∨
        dist P (T.points 2) / dist P Q₃ ≤ 2) ∧
      (2 ≤ dist P (T.points 0) / dist P Q₁ ∨
        2 ≤ dist P (T.points 1) / dist P Q₂ ∨
        2 ≤ dist P (T.points 2) / dist P Q₃) := by sorry
