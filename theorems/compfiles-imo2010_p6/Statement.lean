import Mathlib

noncomputable section

namespace Imo2010P6

noncomputable def rec_max {n : ℕ+} (f : ℕ+ → ℝ) (h : 1 < n) := Finset.max' ((Finset.Icc 1 (n - 1)).image (fun k ↦ f k + f (n - k)))
    (Finset.image_nonempty.mpr (Finset.nonempty_Icc.mpr (PNat.le_sub_one_of_lt h)))

def Rec (s : ℕ+) (f : ℕ+ → ℝ) := ∀ n (h : n > s), f n = rec_max f (one_lt_of_gt h)

variable {a f : ℕ+ → ℝ}

variable {l s n N : ℕ+}

theorem _root_.LeanGolf.compfiles.imo2010_p6 {a : ℕ+ → ℝ} {s : ℕ+} : Rec s a → ∃ l N : ℕ+, (l ≤ s ∧ ∀ n ≥ N, a n = a l + a (n - l)) := by sorry
