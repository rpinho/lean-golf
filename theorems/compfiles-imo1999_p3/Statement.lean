import Mathlib.Data.Finset.Basic
import Mathlib.Tactic

noncomputable section

namespace Imo1999P3

abbrev Square (n : ℕ) := Fin n × Fin n

def Adjacent {n : ℕ} (p1 p2 : Square n) : Prop :=
  let (r1, c1) := p1; let (r2, c2) := p2
  ((r1 : ℤ) - r2).natAbs + ((c1 : ℤ) - c2).natAbs = 1

def IsValidMarking {n : ℕ} (s : Finset (Square n)) : Prop :=
  ∀ p : Square n, ∃ m ∈ s, Adjacent p m

open Finset Classical

abbrev solution_value (n : ℕ) : ℕ := n * (n + 2) / 4

theorem _root_.LeanGolf.compfiles.imo1999_p3 (n : ℕ) (h_pos : 0 < n) (h_even : Even n) :
  IsLeast
    {k : ℕ | ∃ s : Finset (Square n), IsValidMarking s ∧ s.card = k}
    (solution_value n) := by sorry
