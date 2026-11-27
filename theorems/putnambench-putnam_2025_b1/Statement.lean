import Mathlib

open Affine EuclideanGeometry

theorem LeanGolf.putnambench.putnam_2025_b1
    (color : EuclideanSpace ℝ (Fin 2) → Bool)
    (h : ∀ (s : Simplex ℝ (EuclideanSpace ℝ (Fin 2)) 2),
      (∀ i j : Fin 3, color (s.points i) = color (s.points j)) →
      color s.circumcenter = color (s.points 0)) :
    ∃ c : Bool, ∀ P : EuclideanSpace ℝ (Fin 2), color P = c := by sorry
