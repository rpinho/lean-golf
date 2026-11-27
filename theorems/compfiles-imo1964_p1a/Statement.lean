import Mathlib.Data.Nat.ModEq
import Mathlib.Tactic

noncomputable section

namespace Imo1964P1

abbrev solution_set : Set ℕ := { n | n % 3 = 0 }

theorem _root_.LeanGolf.compfiles.imo1964_p1a (n : ℕ) : n ∈ solution_set ↔ 2^n ≡ 1 [MOD 7] := by sorry
