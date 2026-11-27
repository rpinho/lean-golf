import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.Data.Nat.Choose.Factorization

namespace Usa2016P2

open Finset

open scoped Nat

theorem _root_.LeanGolf.compfiles.usa2016_p2 (k : ℕ) (hk : 0 < k) :
    (∏ j ∈ Finset.range k, (j + k) !) ∣ (k ^ 2) ! * ∏ j ∈ Finset.range k, j ! := by sorry
