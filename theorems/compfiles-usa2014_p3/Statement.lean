import Mathlib

notation "Pt" => EuclideanSpace ℝ (Fin 2)

namespace Usa2014P3

open Finset

theorem _root_.LeanGolf.compfiles.usa2014_p3 : ∃ P : ℤ → Pt, ∀ a b c : ℤ,
    a ≠ b ∧ b ≠ c ∧ c ≠ a → (Collinear ℝ {P a, P b, P c} ↔ a + b + c = 2014) := by sorry
