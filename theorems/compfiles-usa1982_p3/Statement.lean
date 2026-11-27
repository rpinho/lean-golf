import Mathlib

noncomputable section

open Affine

open scoped Affine Real

namespace Usa1982P3

abbrev Point := EuclideanSpace ℝ (Fin 2)

noncomputable def trianglePerimeter (A B C : Point) : ℝ :=
  dist A B + dist B C + dist C A

noncomputable def triangleArea (A B C : Point) : ℝ :=
  let s := trianglePerimeter A B C / 2
  Real.sqrt (s * (s - dist A B) * (s - dist B C) * (s - dist C A))

noncomputable def isoperimetricQuotient (A B C : Point) : ℝ :=
  triangleArea A B C / (trianglePerimeter A B C) ^ 2

theorem _root_.LeanGolf.compfiles.usa1982_p3
    (A B C A₁ A₂ : Point)
    (hABC : AffineIndependent ℝ ![A, B, C])
    (hEquilateral : dist A B = dist B C ∧ dist B C = dist C A)
    (hA₁ : A₁ ∈ interior (convexHull ℝ ({A, B, C} : Set Point)))
    (hA₂ : A₂ ∈ interior (convexHull ℝ ({A₁, B, C} : Set Point))) :
    isoperimetricQuotient A₁ B C >
      isoperimetricQuotient A₂ B C := by sorry
