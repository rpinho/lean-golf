import Mathlib.Tactic

noncomputable section

namespace Imo1993P3

open Finset

abbrev dirs : Finset (ℤ × ℤ) := {(1, 0), (-1, 0), (0, 1), (0, -1)}

noncomputable def initPos (n : ℕ) : Finset (ℤ × ℤ) := Ico 0 (n : ℤ) ×ˢ Ico 0 (n : ℤ)

def IsMove (s s' : Finset (ℤ × ℤ)) : Prop :=
  ∃ c : ℤ × ℤ, ∃ d : dirs, c ∈ s ∧ c + d ∈ s ∧ c + d + d ∉ s ∧
    s' = insert (c + d + d) ((s.erase c).erase (c + d))

def Solvable (n : ℕ) : Prop := ∃ c : ℤ × ℤ, Relation.ReflTransGen IsMove (initPos n) {c}

abbrev SolutionSet : Set ℕ := {n | 0 < n ∧ ¬ 3 ∣ n}

theorem _root_.LeanGolf.compfiles.imo1993_p3 (n : ℕ) : Solvable n ↔ n ∈ SolutionSet := by sorry
