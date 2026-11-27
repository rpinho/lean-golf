import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

noncomputable section

namespace Imo2020P5

abbrev SolutionSet : Set ℕ := {n | 1 < n}

noncomputable def geometric_mean {n : ℕ} (f : Fin n → ℕ+) (s : Finset (Fin n)) : ℝ :=
  (∏ i ∈ s, (f i : ℝ))^((1:ℝ)/s.card)

theorem _root_.LeanGolf.compfiles.imo2020_p5 (n : ℕ) :
    n ∈ SolutionSet ↔
    (1 < n ∧
     (∀ f : Fin n → ℕ+,
        (Pairwise fun a b ↦ ∃ s : Finset (Fin n),
          s.Nonempty ∧ geometric_mean f s = (((f a):ℝ) + f b) / 2)
        → ∃ y, ∀ a, f a = y )) := by sorry
