import Mathlib.Algebra.Ring.IsFormallyReal
import Mathlib.Analysis.CStarAlgebra.Classes
import Mathlib.Analysis.Complex.Polynomial.Basic
import Mathlib.RingTheory.SimpleRing.Principal

noncomputable section

namespace Usa2019P6

open Polynomial

abbrev SolutionSet : Set (Polynomial ℝ) := {P | ∃ c : ℝ, P = C c * (X ^ 2 + 3)}

theorem _root_.LeanGolf.compfiles.usa2019_p6 (P : Polynomial ℝ) :
    P ∈ SolutionSet ↔
    ∀ x y z : ℝ, x ≠ 0 → y ≠ 0 → z ≠ 0 → 2 * x * y * z = x + y + z →
      P.eval x / (y * z) + P.eval y / (z * x) + P.eval z / (x * y) =
        P.eval (x - y) + P.eval (y - z) + P.eval (z - x) := by sorry
