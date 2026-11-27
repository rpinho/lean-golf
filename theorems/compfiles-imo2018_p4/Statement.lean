import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Set.Operations
import Mathlib.Order.Bounds.Defs

noncomputable section

namespace Imo2018P4

abbrev Site : Type := Fin 20 × Fin 20

def KnightAdj (a b : Site) : Prop :=
  (a.1.val + 1 = b.1.val ∧ a.2.val + 2 = b.2.val) ∨
  (a.1.val + 2 = b.1.val ∧ a.2.val + 1 = b.2.val) ∨
  (a.1.val + 1 = b.1.val ∧ b.2.val + 2 = a.2.val) ∨
  (a.1.val + 2 = b.1.val ∧ b.2.val + 1 = a.2.val) ∨
  (b.1.val + 1 = a.1.val ∧ a.2.val + 2 = b.2.val) ∨
  (b.1.val + 2 = a.1.val ∧ a.2.val + 1 = b.2.val) ∨
  (b.1.val + 1 = a.1.val ∧ b.2.val + 2 = a.2.val) ∨
  (b.1.val + 2 = a.1.val ∧ b.2.val + 1 = a.2.val)

instance (a b : Site) : Decidable (KnightAdj a b) := by
  unfold KnightAdj; infer_instance

def amyMoves (red blue : Finset Site) : Finset Site :=
  (Finset.univ \ (red ∪ blue)).filter fun a => ∀ r ∈ red, ¬ KnightAdj a r

def benMoves (red blue : Finset Site) : Finset Site :=
  Finset.univ \ (red ∪ blue)

inductive CanEnsure (K : ℕ) : ℕ → Finset Site → Finset Site → Prop
  /-- If Amy already has `K` stones, she is done. -/
  | zero {red blue : Finset Site} (h : K ≤ red.card) : CanEnsure K 0 red blue
  /-- If Amy has no legal move, the game stops; she needs to already
  have `K` stones. -/
  | of_no_move {fuel : ℕ} {red blue : Finset Site} (hm : amyMoves red blue = ∅)
      (h : K ≤ red.card) : CanEnsure K (fuel + 1) red blue
  /-- Amy plays `a`; if Ben cannot reply the game stops and she needs
  `K` stones; otherwise she must still ensure `K` stones after every
  reply of Ben. -/
  | of_move {fuel : ℕ} {red blue : Finset Site} {a : Site} (ha : a ∈ amyMoves red blue)
      (hend : benMoves (insert a red) blue = ∅ → K ≤ (insert a red).card)
      (hcont : ∀ b ∈ benMoves (insert a red) blue,
        CanEnsure K fuel (insert a red) (insert b blue)) :
      CanEnsure K (fuel + 1) red blue

def AmyEnsures (K : ℕ) : Prop := CanEnsure K 400 ∅ ∅

abbrev answer : ℕ := 100

theorem _root_.LeanGolf.compfiles.imo2018_p4 : IsGreatest {K | AmyEnsures K} answer := by sorry
