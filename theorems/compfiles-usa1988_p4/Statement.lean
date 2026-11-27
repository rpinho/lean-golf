import Mathlib
import Mathlib.Geometry.Euclidean.Circumcenter
import Mathlib.Geometry.Euclidean.Triangle

noncomputable section

open scoped EuclideanGeometry

open Affine Module

namespace Usa1988P4

variable {V P : Type*} [NormedAddCommGroup V]

variable [InnerProductSpace ℝ V] [MetricSpace P]

variable [NormedAddTorsor V P] [Fact (finrank ℝ V = 2)]

noncomputable abbrev I (A B C : P)
    (hABC : AffineIndependent ℝ ![A, B, C]) : P :=
  (⟨![A, B, C], hABC⟩ : Triangle ℝ P).incenter

noncomputable abbrev O (A B C : P)
    (hABC : AffineIndependent ℝ ![A, B, C]) : P :=
  (⟨![A, B, C], hABC⟩ : Triangle ℝ P).circumcenter

theorem _root_.LeanGolf.compfiles.usa1988_p4 (A B C : P)
    (hABC : AffineIndependent ℝ ![A, B, C])
    (hIAB : AffineIndependent ℝ ![I A B C hABC, A, B])
    (hIBC : AffineIndependent ℝ ![I A B C hABC, B, C])
    (hICA : AffineIndependent ℝ ![I A B C hABC, C, A]) :
    ∃ ω : EuclideanGeometry.Sphere P,
      0 < ω.radius ∧
        ω.center = O A B C hABC ∧
        O (I A B C hABC) A B hIAB ∈ ω ∧
        O (I A B C hABC) B C hIBC ∈ ω ∧
        O (I A B C hABC) C A hICA ∈ ω := by sorry
