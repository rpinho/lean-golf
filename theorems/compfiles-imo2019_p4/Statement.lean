import Mathlib.Data.Nat.Factorial.BigOperators
import Mathlib.Data.Nat.Multiplicity
import Mathlib.Tactic

noncomputable section

namespace Imo2019P4

open scoped Nat

abbrev solution_set : Set (ℕ × ℕ) := { (1,1), (2,3) }

theorem _root_.LeanGolf.compfiles.imo2019_p4 (n k : ℕ) :
    (n, k) ∈ solution_set ↔
    0 < n ∧ 0 < k ∧
    (k ! : ℤ) = ∏ i ∈ Finset.range n, ((2:ℤ)^n - (2:ℤ)^i) := by sorry
