import Mathlib.Algebra.EuclideanDomain.Basic
import Mathlib.Algebra.EuclideanDomain.Field
import Mathlib.Algebra.Polynomial.BigOperators
import Mathlib.Algebra.Polynomial.RingDivision
import Mathlib.Analysis.Normed.Field.Basic
import Mathlib.Data.Nat.Factorial.BigOperators
import Mathlib.RingTheory.Coprime.Lemmas
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Positivity.Basic
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa1975P3

open Polynomial

noncomputable abbrev answer (n : ℕ) : ℝ := if Odd n then 1 else (n : ℝ) / (n + 2)

theorem _root_.LeanGolf.compfiles.usa1975_p3 (n : ℕ) (p : ℝ[X]) (hp : p.natDegree = n)
    (h : ∀ k ∈ Finset.range (n + 1), p.eval (k : ℝ) = (k : ℝ) / (k + 1)) :
    p.eval ((n : ℝ) + 1) = answer n := by sorry
