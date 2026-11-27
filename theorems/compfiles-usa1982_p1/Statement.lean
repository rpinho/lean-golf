import Mathlib.Algebra.Order.Ring.Star
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Combinatorics.SimpleGraph.Basic
import Mathlib.Tactic.NormNum

noncomputable section

namespace Usa1982P1

open Classical

def FourPointProperty (G : SimpleGraph (Fin 1982)) : Prop :=
  ∀ s : Finset (Fin 1982), s.card = 4 → ∃ v ∈ s, ∀ w ∈ s, w ≠ v → G.Adj v w

def IsUniversal (G : SimpleGraph (Fin 1982)) (v : Fin 1982) : Prop :=
  ∀ w, w ≠ v → G.Adj v w

abbrev solution : ℕ := 1979

theorem _root_.LeanGolf.compfiles.usa1982_p1 :
    IsLeast {n : ℕ | ∃ G : SimpleGraph (Fin 1982), FourPointProperty G ∧
      n = (Finset.univ.filter (IsUniversal G)).card} solution := by sorry
