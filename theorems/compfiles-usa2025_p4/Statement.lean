import Mathlib.Tactic
import Mathlib

namespace Usamo2025P4

open EuclideanGeometry RealInnerProductSpace

theorem _root_.LeanGolf.compfiles.usa2025_p4
    (A B C H F P X Y : EuclideanSpace ℝ (Fin 2))
    (htri : AffineIndependent ℝ ![A, B, C])
    (hacuteA : ∠ B A C < Real.pi / 2)
    (hacuteB : ∠ A B C < Real.pi / 2)
    (hacuteC : ∠ B C A < Real.pi / 2)
    (hH1 : ⟪H -ᵥ A, C -ᵥ B⟫ = 0)
    (hH2 : ⟪H -ᵥ B, C -ᵥ A⟫ = 0)
    (hFline : F ∈ affineSpan ℝ ({A, B} : Set (EuclideanSpace ℝ (Fin 2))))
    (hFperp : ⟪C -ᵥ F, B -ᵥ A⟫ = 0)
    (hPperp : ⟪P -ᵥ H, C -ᵥ B⟫ = 0)
    (hPmid : midpoint ℝ H P ∈ affineSpan ℝ ({B, C} : Set (EuclideanSpace ℝ (Fin 2))))
    (hXline : X ∈ affineSpan ℝ ({B, C} : Set (EuclideanSpace ℝ (Fin 2))))
    (hYline : Y ∈ affineSpan ℝ ({B, C} : Set (EuclideanSpace ℝ (Fin 2))))
    (hXY : X ≠ Y)
    (hcirc : ∃ O : EuclideanSpace ℝ (Fin 2), ∃ r : ℝ,
        dist O A = r ∧ dist O F = r ∧ dist O P = r ∧ dist O X = r ∧ dist O Y = r) :
    dist C X = dist C Y := by sorry
