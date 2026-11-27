import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.Rat.Defs
import Mathlib.Order.WellFounded
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.WLOG

namespace Imo1988P6

theorem _root_.LeanGolf.compfiles.imo1988_p6 {a b : ℕ} (h : a * b + 1 ∣ a ^ 2 + b ^ 2) :
    ∃ d, d ^ 2 = (a ^ 2 + b ^ 2) / (a * b + 1) := by sorry
