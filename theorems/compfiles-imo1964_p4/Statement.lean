import Aesop
import Mathlib.Combinatorics.Pigeonhole
import Mathlib.Tactic.Linarith

namespace Imo1964P4

theorem _root_.LeanGolf.compfiles.imo1964_p4
    (Person Topic : Type)
    [Fintype Person] [DecidableEq Person]
    [Fintype Topic] [DecidableEq Topic]
    (card_person : Fintype.card Person = 17)
    (card_topic : Fintype.card Topic = 3)
    (discusses : Person → Person → Topic)
    (discussion_sym : ∀ p1 p2 : Person, discusses p1 p2 = discusses p2 p1) :
    ∃ t : Topic, ∃ s : Finset Person,
      2 < s.card ∧
        ∀ p1 ∈ s, ∀ p2 ∈ s, p1 ≠ p2 → discusses p1 p2 = t := by sorry
