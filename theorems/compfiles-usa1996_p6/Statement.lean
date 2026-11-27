import Mathlib.Data.Int.Basic
import Mathlib.Data.Nat.Digits.Defs
import Mathlib.Tactic

noncomputable section

namespace Usa1996P6

def UniqueRepresentationSet (X : Set ℤ) : Prop :=
  ∀ n : ℤ, ∃! p : ℤ × ℤ,
    p.1 ∈ X ∧ p.2 ∈ X ∧ p.1 + 2 * p.2 = n

abbrev does_exist : Bool := true

theorem _root_.LeanGolf.compfiles.usa1996_p6 :
    does_exist ↔ ∃ X : Set ℤ, UniqueRepresentationSet X := by sorry
