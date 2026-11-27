import Mathlib

noncomputable section

namespace Imo2025P5

def ValidSeq (c : ℝ) {n : ℕ} (x : Fin n → ℝ) : Prop := (∀ i : Fin n, 0 ≤ x i) ∧
  (∀ i : Fin n, Even (i : ℕ) → (∑ j ≤ i, x j) ≤ c * ((i : ℕ) + 1)) ∧
  (∀ i : Fin n, Odd (i : ℕ) → (∑ j ≤ i, (x j) ^ 2) ≤ ((i : ℕ) + 1))

def Wins (c : ℝ) (p : ℕ) {n : ℕ} (x : Fin n → ℝ) : Prop := ∃ i : Fin n, (i : ℕ) % 2 ≠ p ∧
  IsLeast {j : Fin n | ¬ ValidSeq c (Fin.take ((j : ℕ) + 1) (by lia) x)} i

abbrev Strategy : Type := ⦃k : ℕ⦄ → (Fin k → ℝ) → ℝ

def Strategy.play (s : Strategy) (p : ℕ) (opponentMoves : ℕ → ℝ) : (k : ℕ) → Fin k → ℝ
| 0 => Fin.elim0
| k + 1 => Fin.snoc (s.play p opponentMoves k)
    (if k % 2 = p then s (s.play p opponentMoves k) else opponentMoves k)

def Strategy.Winning (s : Strategy) (c : ℝ) (p : ℕ) : Prop :=
  ∀ opponentMoves : ℕ → ℝ, ∃ k : ℕ, Wins c p (s.play p opponentMoves k)

abbrev answer : Set ℝ × Set ℝ :=
  ({c : ℝ | Real.sqrt 2 / 2 < c}, {c : ℝ | c < Real.sqrt 2 / 2})

open Finset

theorem _root_.LeanGolf.compfiles.imo2025_p5 :
    ({c : ℝ | ∃ s : Strategy, s.Winning c 0}, {c : ℝ | ∃ s : Strategy, s.Winning c 1}) =
      answer := by sorry
