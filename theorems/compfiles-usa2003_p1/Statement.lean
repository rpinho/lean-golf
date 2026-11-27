import Mathlib.Data.Nat.Digits.Lemmas
import Mathlib.Tactic

namespace Usa2003P1

theorem _root_.LeanGolf.compfiles.usa2003_p1 (n : ℕ) :
    ∃ m, (Nat.digits 10 m).length = n ∧
          5^n ∣ m ∧ (Nat.digits 10 m).all (Odd ·) := by sorry
