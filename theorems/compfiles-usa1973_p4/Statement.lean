import Mathlib
import Mathlib.Tactic.LinearCombination

noncomputable section

namespace Usa1973P4

abbrev solution_set : Set (ℂ × ℂ × ℂ) := { ⟨1, 1, 1⟩ }

theorem _root_.LeanGolf.compfiles.usa1973_p4 (x y z : ℂ) :
    x + y + z = 3 ∧
    x ^ 2 + y ^ 2 + z ^ 2 = 3 ∧
    x ^ 3 + y ^ 3 + z ^ 3 = 3 ↔ ⟨x,y,z⟩ ∈ solution_set := by sorry
