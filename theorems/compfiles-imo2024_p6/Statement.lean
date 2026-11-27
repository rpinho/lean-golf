import Mathlib.Data.Rat.Floor
import Mathlib.SetTheory.Cardinal.Basic

noncomputable section

namespace Imo2024P6

def Aquaesulian (f : ℚ → ℚ) : Prop :=
  ∀ x y, f (x + f y) = f x + y ∨ f (f x + y) = x + f y

open scoped Cardinal

namespace General

variable {G : Type*} [AddCommGroup G]

def Aquaesulian (f : G → G) : Prop := ∀ x y, f (f y + x) = f x + y ∨ f (f x + y) = f y + x

end General

abbrev solution : ℕ := 2

theorem _root_.LeanGolf.compfiles.imo2024_p6 :
    (∀ f, Aquaesulian f → #(Set.range (fun x ↦ f x + f (-x))) ≤ solution) ∧
    ∀ c : ℕ,
      (∀ f, Aquaesulian f → #(Set.range (fun x ↦ f x + f (-x))) ≤ c) →
        solution ≤ c := by sorry
