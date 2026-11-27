import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Data.Nat.GCD.Basic
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Tactic.NormNum.Prime
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa1990P3

def ValidCircle {k : ℕ} [NeZero k] (a : Fin k → ℕ) : Prop :=
  ∀ i : Fin k, Nat.Coprime (a i) (a (i + 1))

theorem _root_.LeanGolf.compfiles.usa1990_p3 (n : ℕ) (hn : Odd n) (_hn0 : 0 < n) :
    ∃ a : Fin 14 → ℕ, ∃ b : Fin 19 → ℕ,
      Function.Injective a ∧ Function.Injective b ∧
      Disjoint (Finset.univ.image a) (Finset.univ.image b) ∧
      Finset.univ.image a ∪ Finset.univ.image b = Finset.Icc n (n + 32) ∧
      ValidCircle a ∧ ValidCircle b := by sorry
