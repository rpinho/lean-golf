import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_9_3_2 {f g : Polynomial ℚ} (i j : ℕ)
    (hfg : ∀ n : ℕ, ∃ a : ℤ, (f * g).coeff n = a) :
    ∃ a : ℤ, f.coeff i * g.coeff j = a := by sorry
