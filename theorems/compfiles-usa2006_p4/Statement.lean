import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Analysis.MeanInequalities
import Mathlib
import Mathlib.NumberTheory.Real.Irrational
import Mathlib.Tactic.NormNum.Prime

noncomputable section

namespace Usa2006P4

abbrev SolutionSet : Set ℕ := { n | n = 4 ∨ 6 ≤ n }

theorem _root_.LeanGolf.compfiles.usa2006_p4 (n : ℕ) (hn : 0 < n) :
    n ∈ SolutionSet ↔
      ∃ l : List ℚ, 2 ≤ l.length ∧ (∀ x ∈ l, 0 < x) ∧ l.sum = (n : ℚ) ∧
        l.prod = (n : ℚ) := by sorry
