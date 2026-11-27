import Mathlib.Data.Set.Card

noncomputable section

namespace Imo1966P1

variable {U : Type*} [DecidableEq U]

abbrev solution : ℕ := 6

theorem _root_.LeanGolf.compfiles.imo1966_p1 (A B C : Finset U)
    (h1 : (A ∪ B ∪ C).card = 25)
    (h2 : (B \ A).card = 2 * (C \ A).card)
    (h3 : ((A \ B) \ C).card = 1 + (A ∩ (B ∪ C)).card)
    (h4 : ((A \ B) \ C).card = ((B \ A) \ C).card + ((C \ A) \ B).card) :
    ((B \ A) \ C).card = solution := by sorry
