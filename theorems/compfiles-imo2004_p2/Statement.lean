import Mathlib.Tactic

noncomputable section

namespace Imo2004P2

open Polynomial

abbrev SolutionSet : Set (Polynomial ℝ) := {P | ∃ s t : ℝ, P = s • X ^ 4 + t • X ^ 2}

theorem _root_.LeanGolf.compfiles.imo2004_p2 (P : Polynomial ℝ) :
    P ∈ SolutionSet ↔
    ∀ a b c, a * b + b * c + c * a = 0 →
      P.eval (a - b) + P.eval (b - c) + P.eval (c - a) =
      2 * P.eval (a + b + c) := by sorry
