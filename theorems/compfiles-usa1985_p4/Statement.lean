import Mathlib.Algebra.Order.Ring.Canonical
import Mathlib.Algebra.Order.Star.Basic
import Mathlib.Combinatorics.Enumerative.DoubleCounting
import Mathlib.Combinatorics.SimpleGraph.Finite
import Mathlib.Tactic.Choose
import Mathlib.Tactic.GCongr
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa1985P4

open Finset

def mixedRel (n : ℕ) (G : SimpleGraph (Fin n)) [DecidableRel G.Adj] (X : Fin n)
    (p : Fin n × Fin n) : Prop :=
  X ≠ p.1 ∧ X ≠ p.2 ∧ ((G.Adj X p.1 ∧ ¬ G.Adj X p.2) ∨ (¬ G.Adj X p.1 ∧ G.Adj X p.2))

instance (n : ℕ) (G : SimpleGraph (Fin n)) [DecidableRel G.Adj] (X : Fin n)
    (p : Fin n × Fin n) : Decidable (mixedRel n G X p) := by
  unfold mixedRel
  infer_instance

theorem _root_.LeanGolf.compfiles.usa1985_p4 (n : ℕ) (hn : 2 < n) (G : SimpleGraph (Fin n)) [DecidableRel G.Adj] :
    ∃ A B : Fin n, A ≠ B ∧
      n / 2 - 1 ≤ (Finset.univ.filter fun X =>
        X ≠ A ∧ X ≠ B ∧ (G.Adj X A ↔ G.Adj X B)).card := by sorry
