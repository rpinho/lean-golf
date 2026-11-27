import Mathlib

noncomputable section

namespace Usamo2020P3

open Finset ZMod

abbrev solution_val : ℕ := 2

theorem _root_.LeanGolf.compfiles.usa2020_p3 (p : ℕ) [hp : Fact (Nat.Prime p)] (hp2 : p ≠ 2) :
    ∏ a ∈ Finset.univ.filter (fun (a : ZMod p) => a ≠ 0 ∧ ¬IsSquare a ∧ ¬IsSquare (4 - a)), a = (solution_val : ZMod p) := by sorry
