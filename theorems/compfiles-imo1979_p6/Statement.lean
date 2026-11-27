import Mathlib

noncomputable section

namespace Imo1979P6

open SimpleGraph

abbrev Octagon := cycleGraph 8

abbrev A : Fin 8 := 0

abbrev E : Fin 8 := 4

def isTerminalWalk {V : Type} {G : SimpleGraph V} {u v : V} (w : G.Walk u v) := v ∉ w.support.dropLast

noncomputable def a (n : ℕ) := Set.ncard {w : Octagon.Walk A E | isTerminalWalk w ∧ w.length = n}

instance instFintypeAnd {α : Type} [DecidableEq α] (p q : α → Prop) [inst : Fintype (Subtype p)] [DecidablePred q] : Fintype (Subtype (fun x => q x ∧ p x)) := {
  elems := (inst.elems.filter (fun x => q x.val)).attach.image (fun x => ⟨x.val.val, by grind⟩)
  complete := by
    simp only [Finset.mem_image, Finset.mem_attach, true_and, Subtype.exists, Finset.mem_filter,
      Subtype.forall, Subtype.mk.injEq, exists_prop, exists_and_right, exists_eq_right, and_imp]
    intro a h1 h2
    and_intros
    · use h2
      apply Fintype.complete
    · exact h1
}

instance Set.instFintypeElemOfSubtype {α : Type} (p: α → Prop) [inst : Fintype {x // p x}] : Fintype ({x | p x}) := {
  elems := inst.elems
  complete := by
    simp only [Set.coe_ofPred, Subtype.forall]
    intro a h
    apply Fintype.complete
}

instance instDecidableIsTerminalWalk {V : Type} [DecidableEq V] {G : SimpleGraph V} {u v : V} : DecidablePred (fun (w : G.Walk u v) => isTerminalWalk w) := fun w => by
  unfold isTerminalWalk
  exact inferInstance

theorem _root_.LeanGolf.compfiles.imo1979_p6 (n : ℕ) (npos : 0 < n) : a (2*n-1) = 0 ∧ a (2*n) = ((2+√2)^(n-1) - (2-√2)^(n-1)) / √2 := by sorry
