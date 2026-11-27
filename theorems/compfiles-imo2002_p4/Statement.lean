import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Data.Finset.Sort
import Mathlib
import Mathlib.NumberTheory.Divisors
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.FieldSimp.Lemmas
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Linarith.Preprocessing
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.NormNum.Ineq
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Positivity.Core
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Ring.Basic

noncomputable section

namespace Imo2002P4

open Finset

noncomputable def nthDiv (n i : ℕ) : ℕ :=
  if h : i < n.divisors.card then n.divisors.orderEmbOfFin rfl ⟨i, h⟩ else 1

noncomputable def pairSum (n : ℕ) : ℕ :=
  ∑ i ∈ Finset.range (n.divisors.card - 1), nthDiv n i * nthDiv n (i + 1)

abbrev SolutionSet : Set ℕ := {n | n.Prime}

theorem _root_.LeanGolf.compfiles.imo2002_p4 (n : ℕ) (hn : 1 < n) :
    pairSum n < n ^ 2 ∧ (pairSum n ∣ n ^ 2 ↔ n ∈ SolutionSet) := by sorry
