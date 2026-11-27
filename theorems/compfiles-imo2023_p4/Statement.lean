import Mathlib.Tactic

noncomputable section

namespace Imo2023P4

noncomputable def a (x : Finset.Icc 1 2023 → ℝ) (n : Finset.Icc 1 2023) : ℝ :=
  √((∑ i ∈ Finset.univ.filter (· ≤ n), x i) *
    (∑ i ∈ Finset.univ.filter (· ≤ n), (1 / x i)))

theorem _root_.LeanGolf.compfiles.imo2023_p4
    (x : Finset.Icc 1 2023 → ℝ)
    (hxp : ∀ i, 0 < x i)
    (hxi : x.Injective)
    (hxa : ∀ i : Finset.Icc 1 2023, ∃ k : ℤ, a x i = k)
    : 3034 ≤ a x ⟨2023, by simp⟩ := by sorry
