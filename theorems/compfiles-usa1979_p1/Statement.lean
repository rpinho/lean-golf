import Mathlib.Tactic

noncomputable section

namespace Usa1979P1

structure MultisetNatOfLen14 where
  s : Multiset ℕ
  p : Multiset.card s = 14

abbrev SolutionSet : Set MultisetNatOfLen14 := ∅

theorem _root_.LeanGolf.compfiles.usa1979_p1 : ∀ e, e ∈ SolutionSet ↔ (e.s.map (fun x ↦ x ^ 4)).sum = 1599 := by sorry
