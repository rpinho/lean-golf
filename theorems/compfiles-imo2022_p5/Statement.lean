import Mathlib.Tactic

noncomputable section

namespace Imo2022P5

abbrev solution_set : Set (ℕ × ℕ × ℕ) := { ⟨2,2,2⟩, ⟨3,4,3⟩ }

theorem _root_.LeanGolf.compfiles.imo2022_p5 (a b p : ℕ) (ha : 0 < a) (hb : 0 < b) (hp : p.Prime) :
    ⟨a,b,p⟩ ∈ solution_set ↔ a^p = Nat.factorial b + p := by sorry
