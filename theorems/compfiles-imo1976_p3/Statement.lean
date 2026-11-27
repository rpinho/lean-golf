import Mathlib.Tactic
import Mathlib.Algebra.Order.Floor.Semiring
import Mathlib.Analysis.SpecialFunctions.Pow.Real

noncomputable section

namespace Imo1976P3

noncomputable def k : ℝ := (2 : ℝ) ^ (3 : ℝ)⁻¹

noncomputable abbrev CubeInBox (a b c : ℕ) (p : ℝ × ℝ × ℝ) : Prop :=
  0 ≤ p.1 ∧ p.1 + k ≤ a ∧ 0 ≤ p.2.1 ∧ p.2.1 + k ≤ b ∧ 0 ≤ p.2.2 ∧ p.2.2 + k ≤ c

noncomputable abbrev NonOverlapping (p q : ℝ × ℝ × ℝ) : Prop :=
  p.1 + k ≤ q.1 ∨ q.1 + k ≤ p.1 ∨
    p.2.1 + k ≤ q.2.1 ∨ q.2.1 + k ≤ p.2.1 ∨
      p.2.2 + k ≤ q.2.2 ∨ q.2.2 + k ≤ p.2.2

structure IsPacking (a b c : ℕ) (P : Finset (ℝ × ℝ × ℝ)) : Prop where
  inBox : ∀ p ∈ P, CubeInBox a b c p
  nonOverlapping : ∀ p ∈ P, ∀ q ∈ P, p ≠ q → NonOverlapping p q

abbrev solution_set : Set (ℕ × ℕ × ℕ) := {⟨2, 3, 5⟩, ⟨2, 5, 6⟩}

theorem _root_.LeanGolf.compfiles.imo1976_p3 (a b c : ℕ) (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hab : a ≤ b) (hbc : b ≤ c) :
    ⟨a, b, c⟩ ∈ solution_set ↔
      ∃ P : Finset (ℝ × ℝ × ℝ), IsPacking a b c P ∧
        (∀ P' : Finset (ℝ × ℝ × ℝ), IsPacking a b c P' → P'.card ≤ P.card) ∧
        (2 : ℝ) * P.card = 40 / 100 * (a * b * c : ℝ) := by sorry
