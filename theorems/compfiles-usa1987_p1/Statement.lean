import Mathlib.Algebra.QuadraticDiscriminant
import Mathlib.Tactic

noncomputable section

namespace Usa1987P1

abbrev solution_set : Set (ℤ × ℤ) :=
  { (-1, -1), (8, -10), (9, -6), (9, -21) }

theorem _root_.LeanGolf.compfiles.usa1987_p1 (m n : ℤ) :
    (m, n) ∈ solution_set ↔
    m ≠ 0 ∧ n ≠ 0 ∧ (m^2 + n) * (m + n^2) = (m - n)^3 := by sorry
