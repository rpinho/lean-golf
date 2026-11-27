import Mathlib

noncomputable section

namespace Imo2009P3

def IsArithProg (f : ℕ → ℕ) : Prop := ∃ d : ℕ, ∀ n, f (n + 1) = f n + d

theorem _root_.LeanGolf.compfiles.imo2009_p3 (s : ℕ → ℕ) (hs : StrictMono s) (_hpos : ∀ i, 0 < s i)
    (h1 : IsArithProg (fun n ↦ s (s n)))
    (h2 : IsArithProg (fun n ↦ s (s n + 1))) :
    IsArithProg s := by sorry
