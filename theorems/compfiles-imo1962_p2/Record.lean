import Mathlib.Tactic

theorem _root_.LeanGolf.compfiles.imo1962_p2 (x : ℝ) :
    x ∈ SolutionSet ↔
    x ≤ 3 ∧ -1 ≤ x ∧ 1/2 < √(3 - x) - √(x + 1) := by
  let r := √(31 : ℝ)
  let t := 1 - r/8
  have hr : r^2 = 31 := Real.sq_sqrt (by norm_num)
  have hp : 1 ≤ r := by nlinarith [Real.sqrt_nonneg 31]
  have ha : √(3-t) = (r+1)/4 := by
    rw [show 3-t = ((r+1)/4)^2 by dsimp [t]; nlinarith, Real.sqrt_sq (by linarith)]
  have hb : √(t+1) = (r-1)/4 := by
    rw [show t+1 = ((r-1)/4)^2 by dsimp [t]; nlinarith, Real.sqrt_sq (by linarith)]
  have ht : t ≤ 3 := by dsimp [t]; linarith
  change (-1 ≤ x ∧ x < t) ↔ _
  constructor
  · rintro ⟨hl,h⟩
    have : √(3-t) - √(t+1) < √(3-x) - √(x+1) := by gcongr <;> linarith
    exact ⟨by linarith, hl, by linarith⟩
  · rintro ⟨_,hl,h⟩
    refine ⟨hl, ?_⟩
    by_contra! H
    have : √(3-x) - √(x+1) ≤ √(3-t) - √(t+1) := by gcongr
    linarith
