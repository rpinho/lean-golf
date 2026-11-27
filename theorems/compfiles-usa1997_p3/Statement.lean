import Mathlib.Algebra.EuclideanDomain.Basic
import Mathlib.Algebra.EuclideanDomain.Int
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Algebra.Polynomial.Div
import Mathlib.Algebra.Ring.IsFormallyReal
import Mathlib.Analysis.Normed.Ring.Lemmas
import Mathlib

namespace Usa1997P3

open Polynomial

theorem _root_.LeanGolf.compfiles.usa1997_p3 (n : ℤ) :
    ∃! Q : ℤ[X], (∀ i, 0 ≤ Q.coeff i ∧ Q.coeff i ≤ 9) ∧
      Q.eval (-2) = n ∧ Q.eval (-5) = n := by sorry
