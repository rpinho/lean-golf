import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.ModEq
import Mathlib.Algebra.Field.ZMod
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Ring.Basic

noncomputable section

namespace Imo1995P6

abbrev solution (p : ℕ) : ℕ := 2 + (Nat.choose (2 * p) p - 2) / p

theorem _root_.LeanGolf.compfiles.imo1995_p6 (p : ℕ) (hp : p.Prime) (hodd : Odd p) :
    (((Finset.Icc 1 (2 * p)).powersetCard p).filter
      (fun A ↦ p ∣ ∑ x ∈ A, x)).card = solution p := by sorry
