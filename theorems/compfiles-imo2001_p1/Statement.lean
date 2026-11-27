import Mathlib

noncomputable section

namespace Imo2001P1

open scoped EuclideanGeometry

open EuclideanGeometry Affine.Simplex Affine.Triangle

local instance planeFiniteDim :
    Fact (Module.finrank ℝ (EuclideanSpace ℝ (Fin 2)) = 2) :=
  ⟨finrank_euclideanSpace_fin⟩

noncomputable local instance someOrientation :
    Module.Oriented ℝ (EuclideanSpace ℝ (Fin 2)) (Fin 2) :=
  ⟨Module.Basis.orientation (Module.finBasisOfFinrankEq _ _ planeFiniteDim.out)⟩

structure Imo2001q1Cfg where
  (A B C : EuclideanSpace ℝ (Fin 2))
  (hABC : AffineIndependent ℝ ![A, B, C])
  (hAcuteA : ∠ C A B < Real.pi / 2)
  (hAcuteB : ∠ A B C < Real.pi / 2)
  (hAcuteC : ∠ B C A < Real.pi / 2)
  (hAB : ∠ A B C + Real.pi / 6 ≤ ∠ B C A)

namespace Imo2001q1Cfg

variable (cfg : Imo2001q1Cfg)

def ABC : Affine.Triangle ℝ (EuclideanSpace ℝ (Fin 2)) :=
  ⟨![cfg.A, cfg.B, cfg.C], cfg.hABC⟩

noncomputable def P : EuclideanSpace ℝ (Fin 2) :=
  cfg.ABC.altitudeFoot 0

end Imo2001q1Cfg

theorem _root_.LeanGolf.compfiles.imo2001_p1
    (A B C : EuclideanSpace ℝ (Fin 2))
    (hABC : AffineIndependent ℝ ![A, B, C])
    (hAcuteA : ∠ C A B < Real.pi / 2)
    (hAcuteB : ∠ A B C < Real.pi / 2)
    (hAcuteC : ∠ B C A < Real.pi / 2)
    (hAB : ∠ A B C + Real.pi / 6 ≤ ∠ B C A)
    : let ABC : Affine.Triangle _ _ := ⟨![A, B, C], hABC⟩
      let P := ABC.altitudeFoot 0
      ∠ C A B + ∠ C ABC.circumcenter P < Real.pi / 2 := by sorry
