import Mathlib.Data.Set.Card
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Order

noncomputable section

namespace Usa1983P5

def fracs (x : ℝ) (n : ℕ) : Set ℚ :=
  { q : ℚ | q.den ≤ n ∧ ↑q ∈ Set.Ioo x (x + 1 / n)}

theorem _root_.LeanGolf.compfiles.usa1983_p5 (x : ℝ) (n : ℕ) (hn : 0 < n) :
    let fracs := { q : ℚ | q.den ≤ n ∧ ↑q ∈ Set.Ioo x (x + 1 / n)}
    fracs.Finite ∧ fracs.ncard ≤ (n + 1) / 2 := by sorry
