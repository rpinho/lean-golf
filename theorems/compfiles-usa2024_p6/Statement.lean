import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.EuclideanDomain.Basic
import Mathlib.Algebra.EuclideanDomain.Field
import Mathlib.Algebra.Order.Chebyshev
import Mathlib.Algebra.Order.Star.Real
import Mathlib.Analysis.Normed.Field.Basic

noncomputable section

namespace Usa2024P6

noncomputable abbrev solution : ℕ → ℕ → ℝ := fun n ℓ =>
  ((n : ℝ) + (ℓ : ℝ) ^ 2 - 2 * (ℓ : ℝ)) / ((n : ℝ) * ((n : ℝ) - 1))

noncomputable def Works (n ℓ : ℕ) (c : ℝ) : Prop :=
  ∀ (k : ℕ), 0 < k → ∀ (x : Fin k → ℝ), (∀ i, 0 ≤ x i) →
    ∀ (A : Fin k → Finset (Fin n)), (∀ i, ℓ ≤ (A i).card) →
      c * (∑ i, x i) ^ 2 ≤
        ∑ i, ∑ j, x i * x j *
          (((A i ∩ A j).card : ℝ) ^ 2 / ((A i).card : ℝ) / ((A j).card : ℝ))

theorem _root_.LeanGolf.compfiles.usa2024_p6 (n ℓ : ℕ) (hn : 2 < n) (hℓ : 1 ≤ ℓ ∧ ℓ ≤ n) :
    IsGreatest {c : ℝ | Works n ℓ c} (solution n ℓ) := by sorry
