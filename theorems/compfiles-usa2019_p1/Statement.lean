import Mathlib.Data.PNat.Basic
import Mathlib.Tactic

noncomputable section

namespace Usa2019P1

abbrev solution_set : Set ℕ+ := { x : ℕ+ | Even x.val }

theorem _root_.LeanGolf.compfiles.usa2019_p1 (m : ℕ+) :
   m ∈ solution_set ↔
    (∃ f : ℕ+ → ℕ+,
      (∀ n, f^[f n] n * f (f n) = n ^ 2) ∧
      m = f 1000) := by sorry
