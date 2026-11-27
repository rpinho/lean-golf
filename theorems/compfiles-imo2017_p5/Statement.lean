import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Data.Finset.Fin
import Mathlib
import Mathlib.Data.ZMod.Defs
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Tactic.Ring

namespace Imo2017P5

open Finset

theorem _root_.LeanGolf.compfiles.imo2017_p5 (N : ℕ) (hN : 1 ≤ N) (a : Fin (N * (N + 1)) → ℕ)
    (ha : Function.Injective a) :
    ∃ f : Fin (2 * N) ↪o Fin (N * (N + 1)), ∀ k : Fin N, ∀ i j : Fin (2 * N),
      (Finset.univ.filter fun t ↦ a (f t) > a (f i)).card = 2 * k.val →
      (Finset.univ.filter fun t ↦ a (f t) > a (f j)).card = 2 * k.val + 1 →
      i.val + 1 = j.val ∨ j.val + 1 = i.val := by sorry
