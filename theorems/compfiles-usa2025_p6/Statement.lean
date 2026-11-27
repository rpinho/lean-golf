import Mathlib.Tactic
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Combinatorics.Hall.Basic
import Mathlib
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Abel
import Mathlib.Tactic.Linarith.Lemmas
import Mathlib.Tactic.Ring.Basic

noncomputable section

namespace Usa2025P6

def arcSet {m : ℕ} (c : ZMod m) (l : ℕ) : Finset (ZMod m) :=
  (Finset.range l).image (fun t : ℕ => c + (t : ZMod m))

structure CirclePartition (m k : ℕ) where
  base : ZMod m
  len : Fin k → ℕ
  len_pos : ∀ i, 1 ≤ len i
  len_sum : ∑ i, len i = m

namespace CirclePartition

variable {m k : ℕ} (P : CirclePartition m k)

def off (i : Fin k) : ℕ := ∑ j ∈ Finset.univ.filter (· < i), P.len j

def start (i : Fin k) : ZMod m := P.base + (P.off i : ZMod m)

def arcOf (i : Fin k) : Finset (ZMod m) := arcSet (P.start i) (P.len i)

end CirclePartition

theorem _root_.LeanGolf.compfiles.usa2025_p6 {m n : ℕ} [NeZero m] (_hm : 0 < m) (hn : 0 < n) (hmn : n ≤ m)
    (like : Fin n → ZMod m → ℝ) (hnn : ∀ p c, 0 ≤ like p c)
    (hpart : ∀ p, ∃ P : CirclePartition m n, ∀ i, 1 ≤ ∑ x ∈ P.arcOf i, like p x) :
    ∃ a : ZMod m → Fin n, ∀ p, 1 ≤ ∑ c ∈ Finset.univ.filter (a · = p), like p c := by sorry
