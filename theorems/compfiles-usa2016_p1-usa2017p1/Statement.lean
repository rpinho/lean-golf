import Mathlib.Data.Nat.Basic
import Mathlib.Data.Nat.ModEq
import Mathlib.Data.Nat.GCD.Basic
import Mathlib.Data.Set.Card
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa2017P1

def condition (a b : ℕ) : Prop :=
  Nat.gcd a b = 1 ∧ a > 1 ∧ b > 1 ∧ (a + b) ∣ (a ^ b + b ^ a)

theorem _root_.LeanGolf.compfiles.usa2016_p1_usa2017p1 :
    Infinite { (x, y) : ℕ × ℕ | condition x y } := by sorry
