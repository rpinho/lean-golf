import Mathlib.Geometry.Euclidean.Sphere.Tangent
import Mathlib.Geometry.Euclidean.PerpBisector
import Mathlib.Geometry.Euclidean.Triangle
import Mathlib.Geometry.Euclidean.Angle.Oriented.Affine

noncomputable section

namespace Usa2000P5

abbrev Circle := EuclideanGeometry.Sphere (EuclideanSpace ℝ (Fin 2))

def ExternallyTangent (c1 c2 : Circle) : Prop :=
  dist c1.center c2.center = c1.radius + c2.radius

abbrev Point := EuclideanSpace ℝ (Fin 2)

noncomputable instance : Module.Oriented ℝ Point (Fin 2) where
  positiveOrientation :=
    (Orientation.map (Fin 2) (WithLp.linearEquiv 2 ℝ (Fin 2 → ℝ))).symm
      (Pi.basisFun ℝ (Fin 2)).orientation

instance : Fact (Module.finrank ℝ Point = 2) where
  out := by
    simp [Point]

theorem _root_.LeanGolf.compfiles.usa2000_p5
    (A : ZMod 3 → EuclideanSpace ℝ (Fin 2))
    (hABC : AffineIndependent ℝ ![A 0, A 1, A 2])
    (ω : Fin 7 → Circle)
    (hTangent : ∀ i, i < 6 → ExternallyTangent (ω i) (ω (i + 1)))
    (hA : ∀ i : Fin 7, (A i ∈ ω i ∧ A (i + 1) ∈ ω i))
    : ω 0 = ω 6 := by sorry
