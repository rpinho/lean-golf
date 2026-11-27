import Mathlib.Data.List.GetD
import Mathlib.Tactic

namespace Imo1983P5

theorem _root_.LeanGolf.compfiles.imo1983_p5 :
  ∃ S : Finset ℕ+, S.card = 1983 ∧
  (∀ x ∈ S, x ≤ 10^5) ∧
  ∀ x ∈ S, ∀ y ∈ S, ∀ z ∈ S, x < y ∧ y < z → x + z ≠ 2 * y := by sorry
