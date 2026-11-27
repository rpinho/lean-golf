import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.LinearAlgebra.Lagrange
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.LinearCombination.Lemmas
import Mathlib.Tactic.Ring.Compare

namespace Usa1995P4

open Polynomial

theorem _root_.LeanGolf.compfiles.usa1995_p4 (a : ℕ → ℤ)
    (hdiv : ∀ n m : ℕ, ((n : ℤ) - (m : ℤ)) ∣ a n - a m)
    (hp : ∃ p : ℤ[X], ∀ n : ℕ, p.eval (n : ℤ) > |a n|) :
    ∃ q : ℚ[X], ∀ n : ℕ, q.eval (n : ℚ) = (a n : ℚ) := by sorry
