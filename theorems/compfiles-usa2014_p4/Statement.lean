import Mathlib.Algebra.CharP.Defs
import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa2014P4

abbrev Cell := ℤ × ℤ

def offsets : Finset Cell := {(1, 0), (-1, 0), (0, 1), (0, -1), (1, -1), (-1, 1)}

def Adj (c d : Cell) : Prop := (d.1 - c.1, d.2 - c.2) ∈ offsets

instance (c d : Cell) : Decidable (Adj c d) := by
  unfold Adj
  infer_instance

def Dirs : Finset Cell := {(1, 0), (0, 1), (1, -1)}

def step (p : Cell) (d : Cell) (i : ℕ) : Cell := (p.1 + (i : ℤ) * d.1, p.2 + (i : ℤ) * d.2)

def Winning (k : ℕ) (s : Finset Cell) : Prop :=
  ∃ d ∈ Dirs, ∃ p : Cell, ∀ i : ℕ, i < k → step p d i ∈ s

def AMove (s s' : Finset Cell) : Prop :=
  ∃ c₁ c₂ : Cell, c₁ ≠ c₂ ∧ Adj c₁ c₂ ∧ c₁ ∉ s ∧ c₂ ∉ s ∧ s' = insert c₁ (insert c₂ s)

def BMove (s t : Finset Cell) : Prop := ∃ c ∈ s, t = s.erase c

inductive AForce (k : ℕ) : Finset Cell → Prop
  | of_win {s s'} : AMove s s' → Winning k s' → AForce k s
  | of_step {s s'} : AMove s s' → (∀ t, BMove s' t → AForce k t) → AForce k s

def ACanWin (k : ℕ) : Prop := AForce k ∅

abbrev solution : ℕ := 6

theorem _root_.LeanGolf.compfiles.usa2014_p4 : IsLeast {k : ℕ | 0 < k ∧ ¬ ACanWin k} solution := by sorry
