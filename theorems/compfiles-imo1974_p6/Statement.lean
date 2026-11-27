import Mathlib.Tactic
import Mathlib.Algebra.Polynomial.Roots

namespace Imo1974P6

open Polynomial

theorem _root_.LeanGolf.compfiles.imo1974_p6 (P : Polynomial ℤ) (hP : 0 < P.natDegree) :
    {k : ℤ | P.eval k ^ 2 = 1}.ncard ≤ P.natDegree + 2 := by sorry
