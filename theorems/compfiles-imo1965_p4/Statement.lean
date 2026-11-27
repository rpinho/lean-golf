import Mathlib.Tactic

noncomputable section

namespace Imo1965P4

abbrev solution : Set (Multiset ℝ) := {{1, 1, 1, 1}, {-1, -1, -1, 3}}

theorem _root_.LeanGolf.compfiles.imo1965_p4 : { S | S.card = 4 ∧ ∀ x ∈ S, x + (S.erase x).prod = 2 } = solution := by sorry
