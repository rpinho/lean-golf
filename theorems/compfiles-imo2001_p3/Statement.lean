import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise
import Mathlib.Algebra.Group.Action.Defs
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Fintype.Prod
import Mathlib.Tactic.NormNum.Ineq

noncomputable section

namespace Imo2001P3

open Finset

def Easy {α : Type} [Fintype α] (F : α → Finset ℕ) (p : ℕ) : Prop := 3 ≤ #{i | p ∈ F i}

theorem _root_.LeanGolf.compfiles.imo2001_p3
    {Girl Boy : Type}
    [Fintype Girl] [Fintype Boy] [DecidableEq Girl] [DecidableEq Boy]
    {G : Girl → Finset ℕ} {B : Boy → Finset ℕ} -- solved problems
    (hcard_girl : 21 = Fintype.card Girl)
    (hcard_boy : 21 = Fintype.card Boy)
    (G_le_6 : ∀ i, #(G i) ≤ 6) -- Every girl solved at most six problems.
    (B_le_6 : ∀ j, #(B j) ≤ 6) -- Every boy solved at most six problems.
    (G_inter_B : ∀ i j, ¬Disjoint (G i) (B j)) :
    ∃ p, Easy G p ∧ Easy B p := by sorry
