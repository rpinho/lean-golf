import Mathlib.Tactic
import Mathlib.Algebra.Order.Field.GeomSum

noncomputable section

namespace Imo1982P3

noncomputable abbrev sol : ℕ → ℝ := fun k ↦ 2⁻¹ ^ k

theorem _root_.LeanGolf.compfiles.imo1982_p3b : Antitone sol ∧ sol 0 = 1 ∧ (∀ k, 0 < sol k)
    ∧ ∀ n, ∑ k ∈ Finset.range n, sol k ^ 2 / sol (k + 1) < 4 := by sorry
