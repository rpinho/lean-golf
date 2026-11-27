import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Analysis.CStarAlgebra.Classes
import Mathlib.RingTheory.RootsOfUnity.Complex
import Mathlib.RingTheory.SimpleRing.Principal
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

namespace Usa1976P5

open Polynomial

theorem _root_.LeanGolf.compfiles.usa1976_p5 (a b c d : Polynomial ℂ)
    (h : a.comp (X ^ 5) + X * b.comp (X ^ 5) + X ^ 2 * c.comp (X ^ 5) =
        (1 + X + X ^ 2 + X ^ 3 + X ^ 4) * d) :
    X - C 1 ∣ a := by sorry
