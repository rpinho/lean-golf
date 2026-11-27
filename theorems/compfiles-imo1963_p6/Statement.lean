import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Data.Fin.VecNotation
import Mathlib.Data.Fintype.Perm

noncomputable section

namespace Imo1963P6

def secondPrediction : Fin 5 → Fin 5 := ![1, 4, 3, 0, 2]

abbrev answer : Equiv.Perm (Fin 5) where
  toFun := ![2, 4, 3, 1, 0]
  invFun := ![4, 3, 0, 2, 1]
  left_inv := by intro x; fin_cases x <;> decide
  right_inv := by intro x; fin_cases x <;> decide

theorem _root_.LeanGolf.compfiles.imo1963_p6 (π : Equiv.Perm (Fin 5))
    -- No student finished in the position predicted by the first prediction
    -- "A, B, C, D, E".
    (h1 : ∀ s : Fin 5, π s ≠ s)
    -- No two students predicted to finish consecutively did so; for example,
    -- the outcome for C and D was not 1, 2 (respectively), or 2, 3, or 3, 4,
    -- or 4, 5.
    (h2 : ∀ i : Fin 4, (π i.succ : ℕ) ≠ (π i.castSucc : ℕ) + 1)
    -- Exactly two students finished in the places predicted by the second
    -- prediction.
    (h3 : (Finset.univ.filter (fun s => π s = secondPrediction s)).card = 2)
    -- Two disjoint pairs of students predicted to finish consecutively did
    -- so. The consecutive pairs of the second prediction "D, A, E, C, B" are
    -- {D, A}, {A, E}, {E, C} and {C, B}; the disjoint pairs among them are
    -- {D, A} & {E, C}, {D, A} & {C, B}, and {A, E} & {C, B}.
    (h4 : ((π 0 : ℕ) = (π 3 : ℕ) + 1 ∧ (π 2 : ℕ) = (π 4 : ℕ) + 1) ∨
           ((π 0 : ℕ) = (π 3 : ℕ) + 1 ∧ (π 1 : ℕ) = (π 2 : ℕ) + 1) ∨
           ((π 4 : ℕ) = (π 0 : ℕ) + 1 ∧ (π 1 : ℕ) = (π 2 : ℕ) + 1)) :
    π = answer := by sorry
