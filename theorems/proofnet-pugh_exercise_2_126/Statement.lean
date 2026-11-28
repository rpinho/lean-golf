import Mathlib

open Filter Real Function
open scoped Topology

theorem LeanGolf.proofnet.pugh_exercise_2_126 {E : Set ℝ}
    (hE : ¬ Set.Countable E) :
    ∃ p : ℝ, ∀ U ∈ 𝓝 p, ¬ Set.Countable (U ∩ E) := by sorry
