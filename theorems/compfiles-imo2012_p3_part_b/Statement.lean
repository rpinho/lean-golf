import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Algebra.Order.Star.Real
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Analysis.SpecificLimits.Basic

noncomputable section

namespace Imo2012P3

inductive Move (N : ℕ) where
  | guess : Finset (Fin N) → Move N
  | ask : Finset (Fin N) → Move N

structure Strategy (N : ℕ) where
  move : List Bool → Move N

def hist (ans : ℕ → Bool) : ℕ → List Bool
  | 0 => []
  | t + 1 => hist ans t ++ [ans t]

def TruthfulAt {N : ℕ} (σ : Strategy N) (x : Fin N) (ans : ℕ → Bool) (i : ℕ) : Prop :=
  ∀ S : Finset (Fin N), σ.move (hist ans i) = Move.ask S → (x ∈ S ↔ ans i = true)

def ConsistentUpTo (k : ℕ) {N : ℕ} (σ : Strategy N) (x : Fin N) (ans : ℕ → Bool)
    (T : ℕ) : Prop :=
  ∀ t : ℕ, t + k + 1 ≤ T → ∃ i : ℕ, t ≤ i ∧ i ≤ t + k ∧ TruthfulAt σ x ans i

def GuaranteesWin (k n : ℕ) {N : ℕ} (σ : Strategy N) : Prop :=
  (∀ (x : Fin N) (ans : ℕ → Bool), (∀ T, ConsistentUpTo k σ x ans T) →
    ∃ T X, σ.move (hist ans T) = Move.guess X) ∧
  (∀ (x : Fin N) (ans : ℕ → Bool) (T : ℕ) (X : Finset (Fin N)),
    σ.move (hist ans T) = Move.guess X → ConsistentUpTo k σ x ans T →
    x ∈ X ∧ X.card ≤ n)

def BobWins (k n N : ℕ) : Prop :=
  ∃ σ : Strategy N, GuaranteesWin k n σ

theorem _root_.LeanGolf.compfiles.imo2012_p3_part_b :
    ∃ k₀ : ℕ, ∀ k ≥ k₀, ∃ n : ℕ, (1.99 : ℝ) ^ k ≤ (n : ℝ) ∧
      ¬ BobWins k n (n + 1) := by sorry
