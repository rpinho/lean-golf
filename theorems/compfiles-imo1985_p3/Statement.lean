import Mathlib.Algebra.CharP.Lemmas
import Mathlib.Algebra.Field.ZMod
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.RingTheory.Polynomial.Basic
import Mathlib.Tactic.NormNum

noncomputable section

namespace Imo1985P3

open Polynomial

noncomputable def oddCount (P : ℤ[X]) : ℕ :=
  (P.support.filter fun n => Odd (P.coeff n)).card

theorem _root_.LeanGolf.compfiles.imo1985_p3 (S : Finset ℕ) (hS : S.Nonempty) :
    oddCount ((1 + X : ℤ[X]) ^ S.min' hS) ≤
      oddCount (∑ i ∈ S, (1 + X : ℤ[X]) ^ i) := by sorry
