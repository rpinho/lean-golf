import Mathlib.Algebra.Order.Archimedean.Real.Hom
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Algebra.Order.Star.Real
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

noncomputable section

namespace Imo2017P3

open InnerProductSpace

abbrev Pt := EuclideanSpace ℝ (Fin 2)

def totalRounds : ℕ := 10 ^ 9

abbrev Strategy := List Pt → Pt

def ValidStrategy (σ : Strategy) : Prop :=
  σ [] = 0 ∧ ∀ (L : List Pt) (q : Pt), dist (σ L) (σ (L ++ [q])) = 1

def reportList (p : ℕ → Pt) : ℕ → List Pt
  | 0 => []
  | (n + 1) => reportList p n ++ [p (n + 1)]

def hunterPos (σ : Strategy) (p : ℕ → Pt) (n : ℕ) : Pt := σ (reportList p n)

def ValidRabbit (A : ℕ → Pt) : Prop :=
  A 0 = 0 ∧ ∀ n, dist (A n) (A (n + 1)) = 1

def ValidReports (A p : ℕ → Pt) : Prop :=
  ∀ n, 1 ≤ n → dist (p n) (A n) ≤ 1

abbrev does_exist : Bool := false

theorem _root_.LeanGolf.compfiles.imo2017_p3 :
    if does_exist then
      ∃ σ : Strategy, ValidStrategy σ ∧
        ∀ A p : ℕ → Pt, ValidRabbit A → ValidReports A p →
          dist (A totalRounds) (hunterPos σ p totalRounds) ≤ 100
    else
      ¬ ∃ σ : Strategy, ValidStrategy σ ∧
        ∀ A p : ℕ → Pt, ValidRabbit A → ValidReports A p →
          dist (A totalRounds) (hunterPos σ p totalRounds) ≤ 100 := by sorry
