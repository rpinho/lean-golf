import Mathlib

open Affine EuclideanGeometry Module

open scoped Real

namespace Imo1974P2

variable {V Pt : Type*}

variable [NormedAddCommGroup V] [InnerProductSpace ℝ V] [MetricSpace Pt]

variable [NormedAddTorsor V Pt]

variable [Fact (finrank ℝ V = 2)]

theorem _root_.LeanGolf.compfiles.imo1974_p2
    (A B C : Pt)
    (affineIndependent_ABC : AffineIndependent ℝ ![A, B, C]) :
    (∃ D : Pt,
        Wbtw ℝ A D B ∧
          dist C D = Real.sqrt (dist A D * dist D B)) ↔
      Real.sin (∠ B A C) * Real.sin (∠ A B C) ≤
        Real.sin (∠ A C B / 2) ^ 2 := by sorry
