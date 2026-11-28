import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

theorem LeanGolf.proofnet.munkres_exercise_19_6a
  {ι : Type*}
  {f : ι → Type*} {x : ℕ → Πa, f a}
  (y : Πi, f i)
  [Πa, TopologicalSpace (f a)] :
  Tendsto x atTop (𝓝 y) ↔ ∀ i, Tendsto (λ j => (x j) i) atTop (𝓝 (y i)) := by sorry
