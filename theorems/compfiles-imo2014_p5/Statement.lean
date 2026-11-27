import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Data.Fintype.BigOperators
import Mathlib
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.FieldSimp.Lemmas
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Linarith.Preprocessing
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Ring.Basic

noncomputable section

namespace Imo2014P5

def value (c : Multiset ℕ) : ℚ := (c.map fun n : ℕ ↦ (n : ℚ)⁻¹).sum

theorem _root_.LeanGolf.compfiles.imo2014_p5 (c : Multiset ℕ) (hpos : ∀ n ∈ c, 0 < n)
    (hval : value c ≤ 99 + 1 / 2) :
    ∃ gs : Multiset (Multiset ℕ), gs.sum = c ∧ gs.card ≤ 100 ∧
      ∀ g ∈ gs, value g ≤ 1 := by sorry
