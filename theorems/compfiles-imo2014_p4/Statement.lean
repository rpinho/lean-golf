import Mathlib

noncomputable section

namespace Imo2014P4

open scoped EuclideanGeometry

open EuclideanGeometry Affine

local instance planeFiniteDim :
    Fact (Module.finrank ℝ (EuclideanSpace ℝ (Fin 2)) = 2) :=
  ⟨finrank_euclideanSpace_fin⟩

noncomputable local instance someOrientation :
    Module.Oriented ℝ (EuclideanSpace ℝ (Fin 2)) (Fin 2) :=
  ⟨Module.Basis.orientation (Module.finBasisOfFinrankEq _ _ planeFiniteDim.out)⟩

structure Imo2014q4Cfg where
  (A B C P Q M N : EuclideanSpace ℝ (Fin 2))
  (hABC : AffineIndependent ℝ ![A, B, C])
  (acuteA : ∠ C A B < Real.pi / 2)
  (acuteB : ∠ A B C < Real.pi / 2)
  (acuteC : ∠ B C A < Real.pi / 2)
  (hP : Wbtw ℝ B P C)
  (hQ : Wbtw ℝ B Q C)
  (hPAB : ∠ P A B = ∠ B C A)
  (hCAQ : ∠ C A Q = ∠ A B C)
  (hPAM : P = midpoint ℝ A M)
  (hQAN : Q = midpoint ℝ A N)

namespace Imo2014q4Cfg

variable (cfg : Imo2014q4Cfg)

def ABC : Affine.Triangle ℝ (EuclideanSpace ℝ (Fin 2)) :=
  ⟨![cfg.A, cfg.B, cfg.C], cfg.hABC⟩

end Imo2014q4Cfg

theorem _root_.LeanGolf.compfiles.imo2014_p4
    (A B C P Q M N : EuclideanSpace ℝ (Fin 2))
    (hABC : AffineIndependent ℝ ![A, B, C])
    (acuteA : ∠ C A B < Real.pi / 2)
    (acuteB : ∠ A B C < Real.pi / 2)
    (acuteC : ∠ B C A < Real.pi / 2)
    (hP : Wbtw ℝ B P C)
    (hQ : Wbtw ℝ B Q C)
    (hPAB : ∠ P A B = ∠ B C A)
    (hCAQ : ∠ C A Q = ∠ A B C)
    (hPAM : P = midpoint ℝ A M)
    (hQAN : Q = midpoint ℝ A N)
    : let ABC : Affine.Triangle _ _ := ⟨![A, B, C], hABC⟩
      let D := (line[ℝ, B, M] : Set _) ∩ (line[ℝ, C, N] : Set (EuclideanSpace ℝ (Fin 2)))
      Set.Nonempty D ∧ D ⊆ Affine.Simplex.circumsphere ABC := by sorry
