import Mathlib.NumberTheory.Multiplicity
import Mathlib.Tactic

noncomputable section

namespace Imo1990P3

abbrev solution_set : Set ℕ := { 3 }

theorem _root_.LeanGolf.compfiles.imo1990_p3 (n : ℕ) (hn : 1 < n) : n ∈ solution_set ↔ n^2 ∣ 2^n + 1 := by sorry
