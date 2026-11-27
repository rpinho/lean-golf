import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa2024P4

abbrev Necklace (m n : ℕ) := ZMod (m * n) → Bool

def blockCount {m n : ℕ} (c : Necklace m n) (s : ZMod (m * n)) (i : ℕ) : ℕ :=
  ∑ j ∈ Finset.range n, if c (s + ((i * n + j : ℕ) : ZMod (m * n))) then 1 else 0

def AllCutsDistinct {m n : ℕ} (c : Necklace m n) : Prop :=
  ∀ s : ZMod (m * n), Function.Injective (fun i : Fin m ↦ blockCount c s i.val)

abbrev solution : ℕ → ℕ → Prop := fun m n ↦ m ≤ n + 1

theorem _root_.LeanGolf.compfiles.usa2024_p4 (m n : ℕ) (hm : 0 < m) (hn : 0 < n) :
    (∃ c : Necklace m n, AllCutsDistinct c) ↔ solution m n := by sorry
