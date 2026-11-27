import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Combinatorics.SimpleGraph.Girth

noncomputable section

namespace Imo2019P3

open SimpleGraph Finset

attribute [local instance] Classical.propDecidable

attribute [-instance] SimpleGraph.Sup.adjDecidable SimpleGraph.Inf.adjDecidable
  SimpleGraph.Sdiff.adjDecidable SimpleGraph.Bot.adjDecidable
  SimpleGraph.Top.adjDecidable SimpleGraph.Compl.adjDecidable
  SimpleGraph.fintypeEdgeSetSup SimpleGraph.fintypeEdgeSetInf
  SimpleGraph.fintypeEdgeSetSdiff SimpleGraph.fintypeEdgeSetBot

def Toggle {V : Type*} (G G' : SimpleGraph V) : Prop :=
  ∃ a b c : V, b ≠ c ∧ G.Adj a b ∧ G.Adj a c ∧ ¬ G.Adj b c ∧
    G' = (G.deleteEdges {s(a, b), s(a, c)}) ⊔ fromEdgeSet {s(b, c)}

variable {V : Type*} [Fintype V] [DecidableEq V]

theorem _root_.LeanGolf.compfiles.imo2019_p3 (G : SimpleGraph (Fin 2019))
    (h1009 : (Finset.univ.filter (fun v => G.degree v = 1009)).card = 1010)
    (h1010 : (Finset.univ.filter (fun v => G.degree v = 1010)).card = 1009) :
    ∃ G' : SimpleGraph (Fin 2019), Relation.ReflTransGen Toggle G G' ∧
      ∀ v, G'.degree v ≤ 1 := by sorry
