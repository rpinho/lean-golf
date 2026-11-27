import Mathlib.Algebra.Order.Star.Real
import Mathlib.Combinatorics.SimpleGraph.Clique
import Mathlib.Combinatorics.SimpleGraph.DegreeSum

namespace Usa1995P5

open Finset SimpleGraph

variable {n : ℕ} (G : SimpleGraph (Fin n)) [DecidableRel G.Adj]

theorem _root_.LeanGolf.compfiles.usa1995_p5 {n : ℕ} [NeZero n] (G : SimpleGraph (Fin n))
    [DecidableRel G.Adj] (hG : G.CliqueFree 3) :
    ∃ P : Fin n,
      (#(G.edgeFinset.filter fun e => ∀ v ∈ e, ¬G.Adj P v) : ℝ)
        ≤ (#G.edgeFinset : ℝ) * (1 - 4 * #G.edgeFinset / n ^ 2) := by sorry
