import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset
open scoped BigOperators

local notation "limsup" => fun u : ℕ → EReal => Filter.limsup u Filter.atTop

theorem LeanGolf.proofnet.rudin_exercise_3_5
    (a b : ℕ → ℝ)
    (h1 : limsup (fun n => (a n : EReal)) ≠ ⊥ ∨ limsup (fun n => (b n : EReal)) ≠ ⊤)
    (h2 : limsup (fun n => (a n : EReal)) ≠ ⊤ ∨ limsup (fun n => (b n : EReal)) ≠ ⊥) :
    limsup (fun n => ((a n + b n : ℝ) : EReal)) ≤
      limsup (fun n => (a n : EReal)) + limsup (fun n => (b n : EReal)) := by sorry
