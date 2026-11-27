import Mathlib.Algebra.Order.Archimedean.Real.Basic
import Mathlib.Algebra.Polynomial.Roots

noncomputable section

open Classical Polynomial

namespace Usa2020P5

def Overdetermined (S : Finset (ℝ × ℝ)) : Prop :=
  2 ≤ S.card ∧ ∃ P : ℝ[X], P ≠ 0 ∧ P.natDegree ≤ S.card - 2 ∧ ∀ p ∈ S, P.eval p.1 = p.2

abbrev solution (n : ℕ) : ℕ := 2 ^ (n - 1) - n

theorem _root_.LeanGolf.compfiles.usa2020_p5 (n : ℕ) (hn : 2 ≤ n) :
    IsGreatest {k : ℕ | ∃ S : Finset (ℝ × ℝ), S.card = n ∧ ¬ Overdetermined S ∧
      (S.powerset.filter Overdetermined).card = k} (solution n) := by sorry
