import Mathlib

noncomputable section

namespace Imo1975P4

def A : ℕ := (Nat.digits 10 (4444^4444)).sum

def B : ℕ := (Nat.digits 10 A).sum

abbrev sum_digits_B : ℕ := 7

theorem _root_.LeanGolf.compfiles.imo1975_p4 : sum_digits_B = (Nat.digits 10 B).sum := by sorry
