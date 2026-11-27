import Mathlib.Tactic
import Mathlib.Data.Int.Basic
import Mathlib.Data.Set.Insert
import Mathlib.Algebra.Group.Even

noncomputable section

namespace Usa1976P3

abbrev solution_set : Set (ℤ × ℤ × ℤ) := { ⟨0, 0, 0⟩ }

theorem _root_.LeanGolf.compfiles.usa1976_p3 (a b c : ℤ) :
    a^2 + b^2 + c^2 = a^2 * b^2 ↔ ⟨a,b,c⟩ ∈ solution_set := by sorry
