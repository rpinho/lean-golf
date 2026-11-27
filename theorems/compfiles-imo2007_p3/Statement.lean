import Mathlib.Combinatorics.SimpleGraph.Clique

noncomputable section

namespace Imo2007P3

noncomputable def maxCliqueCard {V : Type*} (G : SimpleGraph V) (A : Finset V) : ℕ :=
  sSup {n : ℕ | ∃ s : Finset V, s ⊆ A ∧ G.IsClique s ∧ s.card = n}

theorem _root_.LeanGolf.compfiles.imo2007_p3 {V : Type*} [Fintype V] [DecidableEq V] (G : SimpleGraph V)
    (hG : Even (maxCliqueCard G Finset.univ)) :
    ∃ A B : Finset V, Disjoint A B ∧ A ∪ B = Finset.univ ∧
      maxCliqueCard G A = maxCliqueCard G B := by sorry
