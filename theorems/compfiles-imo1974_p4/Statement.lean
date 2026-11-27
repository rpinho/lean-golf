import Mathlib.Tactic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Max
import Mathlib.Data.Finset.Powerset
import Mathlib.Data.Finset.Prod
import Mathlib.Order.Interval.Finset.Nat

noncomputable section

namespace Imo1974P4

structure Rect where
  r : ℕ
  c : ℕ
  h : ℕ
  w : ℕ
deriving DecidableEq

def Rect.cells (R : Rect) : Finset (ℕ × ℕ) :=
  Finset.Icc (R.r, R.c) (R.r + (R.h - 1), R.c + (R.w - 1))

def isWhite (x : ℕ × ℕ) : Prop :=
  (x.1 + x.2) % 2 = 0

instance : DecidablePred isWhite :=
  fun x ↦ inferInstanceAs (Decidable ((x.1 + x.2) % 2 = 0))

def Rect.whiteCount (R : Rect) : ℕ :=
  (R.cells.filter isWhite).card

def Rect.blackCount (R : Rect) : ℕ :=
  (R.cells.filter fun x ↦ ¬ isWhite x).card

def board : Finset (ℕ × ℕ) :=
  Finset.Icc (0, 0) (7, 7)

def ValidDecomp (T : Finset Rect) : Prop :=
  (∀ R ∈ T, 1 ≤ R.h ∧ 1 ≤ R.w ∧ R.r + R.h ≤ 8 ∧ R.c + R.w ≤ 8) ∧
  (∀ R₁ ∈ T, ∀ R₂ ∈ T, R₁ ≠ R₂ → R₁.cells ∩ R₂.cells = ∅) ∧
  T.biUnion Rect.cells = board ∧
  (∀ R ∈ T, R.whiteCount = R.blackCount) ∧
  (T.image Rect.whiteCount).card = T.card

instance (T : Finset Rect) : Decidable (ValidDecomp T) := by
  unfold ValidDecomp
  infer_instance

abbrev solutions : Finset (Finset ℕ) :=
  {{1, 2, 3, 4, 5, 7, 10}, {1, 2, 3, 4, 5, 8, 9},
   {1, 2, 3, 4, 6, 7, 9}, {1, 2, 3, 5, 6, 7, 8}}

abbrev maxCount : ℕ := 7

theorem _root_.LeanGolf.compfiles.imo1974_p4 :
    (∀ T : Finset Rect, ValidDecomp T → T.card ≤ maxCount ∧
      (T.card = maxCount → T.image Rect.whiteCount ∈ solutions)) ∧
    ∀ s ∈ solutions, ∃ T : Finset Rect, ValidDecomp T ∧ T.card = maxCount ∧
      T.image Rect.whiteCount = s := by sorry
