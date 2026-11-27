import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Group.Action.Defs
import Mathlib.Algebra.Ring.Parity
import Mathlib.Tactic.DeriveFintype

noncomputable section

namespace Usa1999P5

inductive Piece | S | O
  deriving DecidableEq, Inhabited

instance : Fintype Piece where
  elems := ⟨↑[Piece.S, Piece.O], by decide⟩
  complete := fun x => by cases x <;> decide

abbrev Board := ℕ → Option Piece

def HasSOS (b : Board) : Prop :=
  ∃ i ∈ Finset.range 1998, b i = some Piece.S ∧ b (i + 1) = some Piece.O ∧
    b (i + 2) = some Piece.S

instance (b : Board) : Decidable (HasSOS b) := by
  unfold HasSOS; infer_instance

def HasThreat (b : Board) : Prop :=
  ∃ x ∈ Finset.range 2000, ∃ l : Piece, b x = none ∧
    HasSOS (Function.update b x (some l))

instance (b : Board) : Decidable (HasThreat b) := by
  unfold HasThreat; infer_instance

def IsLosing (b : Board) (x : ℕ) : Prop :=
  b x = none ∧ ∀ l : Piece, HasThreat (Function.update b x (some l))

instance (b : Board) (x : ℕ) : Decidable (IsLosing b x) := by
  unfold IsLosing; infer_instance

def TrapAt (b : Board) (a : ℕ) : Prop :=
  b a = some Piece.S ∧ b (a + 1) = none ∧ b (a + 2) = none ∧ b (a + 3) = some Piece.S

instance (b : Board) (a : ℕ) : Decidable (TrapAt b a) := by
  unfold TrapAt; infer_instance

def HasTrap (b : Board) : Prop := ∃ a ∈ Finset.range 1997, TrapAt b a

instance (b : Board) : Decidable (HasTrap b) := by
  unfold HasTrap; infer_instance

def empties (b : Board) : Finset ℕ := (Finset.range 2000).filter fun i => b i = none

inductive Outcome | p1 | p2 | draw
  deriving DecidableEq

abbrev Strategy := Board → ℕ × Piece

def play : ℕ → Strategy → Strategy → Board → Bool → Outcome
  | 0, _, _, _, _ => .draw
  | fuel + 1, σ₁, σ₂, b, true =>
      if HasSOS b then .p2
      else if empties b = ∅ then .draw
      else if (σ₁ b).1 < 2000 ∧ b (σ₁ b).1 = none
      then play fuel σ₁ σ₂ (Function.update b (σ₁ b).1 (some (σ₁ b).2)) false
      else .p2
  | fuel + 1, σ₁, σ₂, b, false =>
      if HasSOS b then .p1
      else if empties b = ∅ then .draw
      else if (σ₂ b).1 < 2000 ∧ b (σ₂ b).1 = none
      then play fuel σ₁ σ₂ (Function.update b (σ₂ b).1 (some (σ₂ b).2)) true
      else .p1

def SafeMove (b : Board) (x : ℕ) (l : Piece) : Prop :=
  x < 2000 ∧ b x = none ∧ ¬ IsLosing b x ∧
    ¬ HasThreat (Function.update b x (some l)) ∧ ¬ HasSOS (Function.update b x (some l))

instance (b : Board) (x : ℕ) (l : Piece) : Decidable (SafeMove b x l) := by
  unfold SafeMove; infer_instance

def SecondSetupOk (b : Board) (t : ℕ) : Prop :=
  b t = none ∧ ¬ HasThreat (Function.update b t (some Piece.S)) ∧
    ¬ HasSOS (Function.update b t (some Piece.S)) ∧
    HasTrap (Function.update b t (some Piece.S))

instance (b : Board) (t : ℕ) : Decidable (SecondSetupOk b t) := by
  unfold SecondSetupOk; infer_instance

theorem _root_.LeanGolf.compfiles.usa1999_p5 :
    ∃ σ : Strategy, ∀ τ : Strategy, play 2001 τ σ (fun _ => none) true = Outcome.p2 := by sorry
