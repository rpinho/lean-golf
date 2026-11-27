import Mathlib.Analysis.Convex.StrictConvexBetween
import Mathlib.Geometry.Euclidean.Triangle
import Mathlib.Tactic

noncomputable section

namespace Imo1983P6

abbrev EqualityCondition (a b c : ℝ) : Prop := a = b ∧ a = c

theorem _root_.LeanGolf.compfiles.imo1983_p6 (T : Affine.Triangle ℝ (EuclideanSpace ℝ (Fin 2))) :
    let a := dist (T.points 1) (T.points 2)
    let b := dist (T.points 0) (T.points 2)
    let c := dist (T.points 0) (T.points 1)
    0 ≤ a^2 * b * (a - b) + b^2 * c * (b - c) + c^2 * a * (c - a) ∧
    (0 = a^2 * b * (a - b) + b^2 * c * (b - c) + c^2 * a * (c - a) ↔
     EqualityCondition a b c) := by sorry
