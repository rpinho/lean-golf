import Mathlib

noncomputable section

namespace Imo2000P5

open Nat Finset

abbrev solution : Bool := true

theorem _root_.LeanGolf.compfiles.imo2000_p5 :
    ∃ n, 0 < n ∧ n.primeFactors.card = 2000 ∧ n ∣ 2 ^ n + 1
    ↔ solution := by sorry
