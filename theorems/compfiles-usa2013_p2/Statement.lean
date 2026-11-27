import Mathlib.Algebra.BigOperators.Fin
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.SetTheory.Cardinal.Finite
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa2013P2

abbrev ColSeq (n : ℕ) := Fin (n + 1) → Fin 3

abbrev AdjDistinct {n : ℕ} (c : ColSeq n) : Prop := ∀ i : Fin n, c i.castSucc ≠ c i.succ

noncomputable def countCol (n : ℕ) (s t : Fin 3) : ℕ :=
  Nat.card {c : ColSeq n // AdjDistinct c ∧ c 0 = s ∧ c (Fin.last n) = t}

noncomputable def a (n : ℕ) : ℕ := countCol n 0 1 + countCol n 2 2

theorem _root_.LeanGolf.compfiles.usa2013_p2 (n : ℕ) (hn : 4 ≤ n) : a (n - 1) + a n = 2 ^ n := by sorry
