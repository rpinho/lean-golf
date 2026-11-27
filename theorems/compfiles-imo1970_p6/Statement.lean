import Mathlib

noncomputable section

namespace Imo1970P6

open scoped EuclideanGeometry Real RealInnerProductSpace

open EuclideanGeometry Finset

abbrev Pt := EuclideanSpace ℝ (Fin 2)

theorem _root_.LeanGolf.compfiles.imo1970_p6
    (P : Fin 100 → Pt)
    (hP : ∀ a b c : Fin 100,
             List.Nodup [a, b, c] → ¬ Collinear ℝ {P a, P b, P c}) :
    let cardAll := Nat.card { s : Finset (Fin 100) | s.card = 3 }
    let cardAcute := Nat.card { s : Finset (Fin 100) | s.card = 3 ∧
      ∃ a b c : Fin 100, s = {a, b, c} ∧
      ∃ t : Affine.Triangle ℝ Pt, ![P a, P b, P c] = t.points ∧ t.AcuteAngled }
    (cardAcute : ℚ) / cardAll ≤ 7 / 10 := by sorry
