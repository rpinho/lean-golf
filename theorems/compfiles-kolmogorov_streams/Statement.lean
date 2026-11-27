import Mathlib.Data.Stream.Defs
import Mathlib.Data.Stream.Init
import Mathlib.Tactic

noncomputable section

namespace KolmogorovStreams

open scoped Stream'

variable {α : Type}

def break_into_words :
   (Stream' ℕ) → -- word lengths
   (Stream' α) → -- original sequence
   (Stream' (List α)) -- sequence of words
 := Function.curry
     (Stream'.corec
       (fun ⟨lengths, a'⟩ ↦ a'.take lengths.head)
       (fun ⟨lengths, a'⟩ ↦ ⟨lengths.tail, a'.drop lengths.head⟩))

def all_same_class
    (is_decent : List α → Prop)
    (b : Stream' (List α))
    : Prop :=
  b.All is_decent ∨ b.All (fun w ↦ ¬is_decent w)

theorem _root_.LeanGolf.compfiles.kolmogorov_streams
    (is_decent : List α → Prop)
    (a : Stream' α)
    : (∃ (lengths : Stream' ℕ),
       (lengths.All (0 < ·) ∧
        all_same_class is_decent (break_into_words lengths a).tail)) := by sorry
