import Mathlib.Analysis.Real.Sqrt
import Mathlib.Tactic.Linarith

theorem LeanGolf.am_gm (x y : ℝ) (hx : 0 ≤ x) (hy : 0 ≤ y) : Real.sqrt (x * y) ≤ (x + y) / 2 := by
  refine Real.sqrt_le_iff.mpr ⟨by linarith, ?_⟩
  nlinarith [sq_nonneg (x - y)]
