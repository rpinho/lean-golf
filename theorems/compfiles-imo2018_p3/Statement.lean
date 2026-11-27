import Mathlib.Tactic
import Mathlib.Data.Nat.Dist

noncomputable section

public section

namespace Imo2018P3

structure Coords where
(row : ℕ) (col : ℕ)
deriving DecidableEq

def left_child (c : Coords) : Coords :=
 ⟨c.row.succ, c.col⟩

def right_child (c : Coords) : Coords :=
  ⟨c.row.succ, c.col.succ⟩

structure antipascal_triangle (n : ℕ) where
(f : Coords → ℕ)
(antipascal : ∀ x : Coords, x.row + 1 < n ∧ x.col ≤ x.row →
  f x = Nat.dist (f (left_child x)) (f (right_child x)))

def exists_desired_triangle : Prop :=
   ∃ t : antipascal_triangle 2018,
     ∀ n, 1 ≤ n → n ≤ ∑ i ∈ Finset.range 2018, (i + 1) →
         ∃ r, r < 2018 ∧ ∃ c, c ≤ r ∧ t.f ⟨r,c⟩ = n

end Imo2018P3

end

public section

namespace Imo2018P3

abbrev does_exist : Bool := false

theorem _root_.LeanGolf.compfiles.imo2018_p3 : does_exist ↔ exists_desired_triangle := by sorry
