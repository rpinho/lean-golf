import Mathlib.FieldTheory.Finite.Basic

theorem LeanGolf.fermat_little {p : ℕ} [Fact p.Prime] {a : ZMod p} (ha : a ≠ 0) : a ^ (p - 1) = 1 := by sorry
