import Mathlib.Data.Nat.ModEq
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

noncomputable section

namespace Poland1998P4

def a : ℕ → ℕ
| 0 => 1 -- unused dummy value
| 1 => 1
| Nat.succ n =>
    have _ : (n.succ / 2) < n.succ := Nat.div_lt_self' n 0
    a n + a (n.succ / 2)

theorem _root_.LeanGolf.compfiles.poland1998_p4 : Set.Infinite { n | 7 ∣ a n } := by sorry
