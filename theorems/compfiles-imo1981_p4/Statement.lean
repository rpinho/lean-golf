import Mathlib

noncomputable section

namespace Imo1981P4

open Finset

def last_divides_lcm_remaining (n k : ℕ) : Prop := k+n ∣ lcm (Icc (k+1) (k+n-1)) id

abbrev values_a : Set ℕ := Set.Ici 4

abbrev values_b : Set ℕ := {4}

theorem _root_.LeanGolf.compfiles.imo1981_p4 (n : ℕ) :
      (n ∈ values_a ↔ 2 < n ∧ ∃  k, last_divides_lcm_remaining n k)
    ∧ (n ∈ values_b ↔ 2 < n ∧ ∃! k, last_divides_lcm_remaining n k) := by sorry
