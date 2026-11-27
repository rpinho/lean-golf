import Mathlib.Tactic

noncomputable section

namespace Imo1982P1

abbrev solution_value : ℕ := 660

theorem _root_.LeanGolf.compfiles.imo1982_p1 (f : ℕ → ℕ)
    (h2 : f 2 = 0)
    (h3 : 0 < f 3)
    (h9999 : f 9999 = 3333)
    (hf : ∀ m n, 0 < m → 0 < n → f (m + n) = f m + f n ∨ f (m + n) = f m + f n + 1) :
    f 1982 = solution_value := by sorry
