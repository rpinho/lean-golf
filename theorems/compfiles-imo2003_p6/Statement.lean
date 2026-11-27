import Mathlib.Tactic
import Mathlib.Tactic.NormNum.Prime

namespace Imo2003P6

theorem _root_.LeanGolf.compfiles.imo2003_p6 (p : ℕ) (hp : p.Prime) :
    ∃ q : ℕ, q.Prime ∧ ∀ n, ¬((q : ℤ) ∣ (n : ℤ)^p - (p : ℤ)) := by sorry
