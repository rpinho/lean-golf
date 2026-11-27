import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Data.Fin.VecNotation

noncomputable section

namespace Usa1976P1

def HasMonoRectangle {m n : ℕ} (c : Fin m → Fin n → Bool) : Prop :=
  ∃ r1 r2 : Fin m, ∃ j1 j2 : Fin n, ∃ b : Bool,
    r1 ≠ r2 ∧ j1 ≠ j2 ∧
    c r1 j1 = b ∧ c r2 j1 = b ∧ c r1 j2 = b ∧ c r2 j2 = b

abbrev counterexample : Fin 4 → Fin 6 → Bool :=
  ![![true,  false, true,  false, true,  false],
    ![true,  false, false, true,  false, true ],
    ![false, true,  true,  false, false, true ],
    ![false, true,  false, true,  true,  false]]

theorem _root_.LeanGolf.compfiles.usa1976_p1_second : ¬ HasMonoRectangle counterexample := by sorry
