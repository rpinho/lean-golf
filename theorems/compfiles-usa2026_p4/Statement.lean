import Mathlib.Data.Nat.Digits.Lemmas
import Mathlib.Data.Finset.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.List.DropRight

noncomputable section

namespace Usa2026P4

open Classical

abbrev solution : ℕ := 2^2026 - 1

def has_digit_one (n : ℕ) : Prop :=
  1 ∈ Nat.digits 10 n

def is_solitary (n : ℕ) : Prop :=
  0 < n ∧ ∀ a b : ℕ, a + b = n → has_digit_one a ∨ has_digit_one b

open Nat List

theorem _root_.LeanGolf.compfiles.usa2026_p4 :
    (Finset.filter is_solitary (Finset.Ico 1 (10^2026))).card = solution := by sorry
