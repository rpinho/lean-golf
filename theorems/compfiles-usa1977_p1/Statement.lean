import Mathlib.Algebra.EuclideanDomain.Basic
import Mathlib.Algebra.Field.GeomSum
import Mathlib.Algebra.Polynomial.Div
import Mathlib.Algebra.Polynomial.FieldDivision
import Mathlib.Algebra.Polynomial.Roots
import Mathlib.Data.PNat.Basic
import Mathlib.Algebra.Polynomial.Basic
import Mathlib.RingTheory.RootsOfUnity.Complex
import Mathlib.RingTheory.RootsOfUnity.PrimitiveRoots

noncomputable section

namespace Usa1977P1

open Polynomial

noncomputable def geomSumStep (m n : ℕ+) : ℤ[X] :=
  ∑ k ∈ Finset.range (m + 1), X ^ (k * n : ℕ)

noncomputable def geomSum (m : ℕ+) : ℤ[X] :=
  ∑ k ∈ Finset.range (m + 1), X ^ k

abbrev solution_set : Set (ℕ+ × ℕ+) := {p | ((p.1 : ℕ) + 1).Coprime (p.2 : ℕ) }

theorem _root_.LeanGolf.compfiles.usa1977_p1 (m n : ℕ+) :
    (m, n) ∈ solution_set ↔ geomSum m ∣ geomSumStep m n := by sorry
