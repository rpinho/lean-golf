import Mathlib.Algebra.Group.Submonoid.Membership
import Mathlib
import Mathlib.GroupTheory.Perm.Sign
import Mathlib.Tactic

namespace Imo1997P3

theorem _root_.LeanGolf.compfiles.imo1997_p3 {n : ℕ} {x : Fin n → ℝ} (hx₁ : |∑ i, x i| = 1)
    (hx₂ : ∀ i, |x i| ≤ (n + 1) / 2) :
    ∃ p : Equiv.Perm (Fin n), |∑ i, (i + 1) * x (p i)| ≤ (n + 1) / 2 := by sorry
