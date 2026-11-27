import Mathlib

noncomputable section

open Filter Topology Set Nat

abbrev putnam_2008_b5_solution : Set (ℝ → ℝ) :=
  {fun (x : ℝ) => x + n | n : ℤ} ∪ {fun (x : ℝ) => -x + n | n : ℤ}

theorem LeanGolf.putnambench.putnam_2008_b5
(fqsat : (ℝ → ℝ) → ℚ → Prop)
(hfqsat : ∀ f q, fqsat f q ↔ ContDiff ℝ 1 f ∧ (∃ p : ℚ, p = f q ∧ p.den = q.den))
: ∀ f : (ℝ → ℝ), (∀ q : ℚ, fqsat f q) ↔ f ∈ putnam_2008_b5_solution := by sorry
