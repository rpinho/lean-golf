import Mathlib.Tactic

noncomputable section

namespace Imo1996P3

abbrev SolutionSet : Set (ℕ → ℕ) :=
   { f | ∃ k : ℕ, ∃ n : ℕ → ℕ, n 0 = 0 ∧
          f = fun x ↦ (x / k) * k + (n (x % k)) * k }

theorem _root_.LeanGolf.compfiles.imo1996_p3 (f : ℕ → ℕ) :
    f ∈ SolutionSet ↔ ∀ m n, f (m + f n) = f (f m) + f n := by sorry
