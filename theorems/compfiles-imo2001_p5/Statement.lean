import Mathlib.Geometry.Euclidean.Triangle

noncomputable section

open Affine EuclideanGeometry

open scoped Real

variable {V X : Type*}

variable [NormedAddCommGroup V] [InnerProductSpace ℝ V] [MetricSpace X] [NormedAddTorsor V X]

noncomputable section

namespace Imo2001P5

variable (X) in

structure Setup where
  (A B C P Q : X)
  P_on_BC : Wbtw ℝ B P C
  AP_bisect_BAC : ∠ B A P = ∠ P A C
  Q_on_AC : Wbtw ℝ A Q C
  BQ_bisect_ABC : ∠ A B Q = ∠ Q B C
  dist_sum : dist A B + dist B P = dist A Q + dist Q B
  BAC_eq : ∠ B A C = π / 3

abbrev solution_ABC : ℝ := 4 * π / 9

abbrev solution_ACB : ℝ := 2 * π / 9

theorem _root_.LeanGolf.compfiles.imo2001_p5 (s : Setup X) :
    ∠ s.A s.B s.C = solution_ABC ∧ ∠ s.A s.C s.B = solution_ACB := by sorry
