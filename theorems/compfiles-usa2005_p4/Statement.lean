import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Data.Finset.NatAntidiagonal
import Mathlib.Data.Set.Card
import Mathlib.Tactic.NormNum.BigOperators
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa2005P4

abbrev solution (n : ℕ) : ℕ := (n + 1) * (2 * n ^ 2 + 4 * n + 3) / 3

theorem _root_.LeanGolf.compfiles.usa2005_p4 (n : ℕ) :
    {k : ℕ × ℕ × ℕ × ℕ | k.1 ≤ n ∧ k.2.1 ≤ n ∧ k.2.2.1 ≤ n ∧ k.2.2.2 ≤ n ∧
      k.1 + k.2.2.1 = k.2.1 + k.2.2.2}.ncard = solution n := by sorry
