import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Analysis.Normed.Ring.Lemmas
import Mathlib
import Mathlib.RingTheory.Coprime.Lemmas
import Mathlib.Tactic.IntervalCases

noncomputable section

namespace Imo1967P6

abbrev MedalsProcess (m n : ℕ) (r : ℕ → ℤ) : Prop :=
    r 0 = ↑m ∧ r (n - 1) = ↑n ∧
      ∀ k, 1 ≤ k → k ≤ n - 1 →
        7 ∣ r (k - 1) - ↑k ∧ r k = r (k - 1) - (↑k + (r (k - 1) - ↑k) / 7)

abbrev solution : ℕ × ℕ := (36, 6)

theorem _root_.LeanGolf.compfiles.imo1967_p6 (m n : ℕ) (hn : 1 < n) :
    (∃ r : ℕ → ℤ, MedalsProcess m n r) ↔ (m, n) = solution := by sorry
