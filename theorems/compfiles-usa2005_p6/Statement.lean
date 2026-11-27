import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Algebra.Order.Star.Real
import Mathlib.Analysis.SpecialFunctions.Log.Base
import Mathlib.Data.Nat.Digits.Lemmas

noncomputable section

namespace Usa2005P6

def s (m : ℕ) : ℕ := (Nat.digits 10 m).sum

def IsStable (k : ℕ) (S : Finset ℕ) : Prop :=
  (∀ x ∈ S, 0 < x) ∧ ∀ X ∈ S.powerset, X.Nonempty → s (∑ x ∈ X, x) = k

noncomputable def f (n : ℕ) : ℕ := sInf {k | ∃ S : Finset ℕ, IsStable k S ∧ S.card = n}

theorem _root_.LeanGolf.compfiles.usa2005_p6 : ∃ C₁ C₂ : ℝ, 0 < C₁ ∧ C₁ < C₂ ∧
    ∀ n : ℕ, 2 ≤ n → C₁ * Real.logb 10 n ≤ (f n : ℝ) ∧ (f n : ℝ) ≤ C₂ * Real.logb 10 n := by sorry
