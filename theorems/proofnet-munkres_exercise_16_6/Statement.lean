import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

def rational (x : ℝ) := x ∈ range ((↑) : ℚ → ℝ)

theorem LeanGolf.proofnet.munkres_exercise_16_6 :
    IsTopologicalBasis
      (Set.image2 (fun s t => s ×ˢ t)
        (⋃ (a : ℚ) (b : ℚ) (_ : a < b), {Set.Ioo (a : ℝ) b})
        (⋃ (a : ℚ) (b : ℚ) (_ : a < b), {Set.Ioo (a : ℝ) b})) := by sorry
