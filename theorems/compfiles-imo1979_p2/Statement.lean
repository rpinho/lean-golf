import Mathlib.Tactic

namespace Imo1979P2

theorem _root_.LeanGolf.compfiles.imo1979_p2 (a b : Fin 5 → Bool) (c : Fin 5 → Fin 5 → Bool)
    (ha : ∀ i j : Fin 5, ¬ (a i = c i j ∧ c i j = c (i + 1) j))
    (hb : ∀ i j : Fin 5, ¬ (b j = c i j ∧ c i j = c i (j + 1))) :
    ∃ col : Bool, (∀ i : Fin 5, a i = col) ∧ (∀ i : Fin 5, b i = col) := by sorry
