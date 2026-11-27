import Mathlib.NumberTheory.Wilson

theorem LeanGolf.wilson {n : ℕ} (h : n ≠ 1) : n.Prime ↔ ((n - 1).factorial : ZMod n) = -1 := by sorry
