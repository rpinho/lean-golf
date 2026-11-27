import Mathlib.Tactic
import Mathlib.Algebra.Order.Field.GeomSum

namespace Imo1982P3

theorem _root_.LeanGolf.compfiles.imo1982_p3a {x : ℕ → ℝ} (hx : Antitone x) (h0 : x 0 = 1) (hp : ∀ k, 0 < x k) :
    ∃ n : ℕ, 3.999 ≤ ∑ k ∈ Finset.range n, (x k) ^ 2 / x (k + 1) := by sorry
