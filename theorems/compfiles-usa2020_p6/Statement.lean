import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.Star.Real
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Data.Fintype.Perm

namespace Usa2020P6

open Finset Nat

theorem _root_.LeanGolf.compfiles.usa2020_p6 {n : ℕ} (hn : 2 ≤ n) (x y : Fin n → ℝ)
    (hx : Antitone x) (hy : Antitone y)
    (hxs : ∑ i, x i = 0) (hys : ∑ i, y i = 0)
    (hx2 : ∑ i, x i ^ 2 = 1) (hy2 : ∑ i, y i ^ 2 = 1) :
    ∑ i, (x i * y i - x i * y (Fin.rev i)) ≥ 2 / Real.sqrt ((n : ℝ) - 1) := by sorry
