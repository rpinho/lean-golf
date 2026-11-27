import Mathlib.Algebra.Order.Archimedean.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Order.Lattice.Nat
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa1980P2

open Finset

noncomputable def apPairs (n : ℕ) (a : ℕ → ℝ) (j : ℕ) : Finset (ℕ × ℕ) :=
  ((range j) ×ˢ (Ioo j n)).filter fun p => a p.1 + a p.2 = 2 * a j

noncomputable def apCount (n : ℕ) (a : ℕ → ℝ) : ℕ :=
  ∑ j ∈ range n, (apPairs n a j).card

abbrev answer (n : ℕ) : ℕ := (n - 1)^2 / 4

theorem _root_.LeanGolf.compfiles.usa1980_p2 (n : ℕ) :
    IsGreatest {m : ℕ | ∃ a : ℕ → ℝ, StrictMonoOn a (Set.Iio n) ∧ m = apCount n a}
      (answer n) := by sorry
