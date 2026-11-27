import Mathlib.Algebra.CharP.Defs
import Mathlib.Algebra.Ring.IsFormallyReal
import Mathlib.Analysis.Normed.Field.Lemmas
import Mathlib.Data.Int.ModEq
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.Prime.Int
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.LinearCombination.Lemmas

noncomputable section

namespace Usa2019P5

inductive Writable (m n : ℕ) : ℚ → Prop
  | base₁ : Writable m n ((m : ℚ) / n)
  | base₂ : Writable m n ((n : ℚ) / m)
  | am {x y : ℚ} : Writable m n x → Writable m n y → Writable m n ((x + y) / 2)
  | hm {x y : ℚ} : Writable m n x → Writable m n y → Writable m n (2 * x * y / (x + y))

abbrev solution_set : Set (ℕ × ℕ) := { (m, n) | ∃ k : ℕ, m + n = 2 ^ k }

theorem _root_.LeanGolf.compfiles.usa2019_p5 (m n : ℕ) (hm : 0 < m) (hn : 0 < n) (hmn : m.Coprime n) :
    (m, n) ∈ solution_set ↔ Writable m n 1 := by sorry
