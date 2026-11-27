import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise
import Mathlib.Algebra.BigOperators.Group.Finset.Sigma
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.NormNum.BigOperators

noncomputable section

namespace Usa1985P5

noncomputable abbrev c (a : ℕ → ℕ) (hu : ∀ n, ∃ i, n ≤ a i) (n : ℕ) : ℕ :=
  Nat.find (hu n)

abbrev solution : ℕ := 1700

theorem _root_.LeanGolf.compfiles.usa1985_p5 :
    IsGreatest { s : ℕ | ∃ (a : ℕ → ℕ) (_ : Monotone a) (_ : 0 < a 0)
        (hu : ∀ n, ∃ i, n ≤ a i), a 18 = 85 ∧
        s = ∑ i ∈ Finset.range 19, a i + ∑ j ∈ Finset.range 85, (c a hu (j + 1) + 1) }
      solution := by sorry
