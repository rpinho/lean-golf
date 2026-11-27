import Mathlib.Tactic
import Mathlib.Data.Nat.Dist

noncomputable section

namespace Imo1989P6

open Equiv

variable (n : ℕ)

def T (x : Perm (Finset.Icc 1 (2*n))) :=
  ∃ i, ∃ _ : i ∈ Finset.Icc 1 (2*n-1),
    (x ⟨i, by grind⟩ : ℕ).dist (x ⟨i+1, by grind⟩) = n

instance instOne [NeZero n] : OfNat ↥(Finset.Icc 1 (2 * n)) 1 := ⟨⟨1, by simpa using NeZero.one_le⟩⟩

theorem _root_.LeanGolf.compfiles.imo1989_p6 (npos : 0 < n) : {x | T n x}.ncard > {x | ¬ T n x}.ncard := by sorry
