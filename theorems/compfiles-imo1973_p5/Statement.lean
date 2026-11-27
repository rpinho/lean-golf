import Mathlib.Tactic

namespace Imo1973P5

theorem _root_.LeanGolf.compfiles.imo1973_p5 {G : Set (ℝ → ℝ)}
    (hf: ∀ f ∈ G, ∃ a b : ℝ, a ≠ 0 ∧ ∀ x : ℝ, f x = a * x + b)
    (hG : ∀ f ∈ G, ∀ g ∈ G, g ∘ f ∈ G)
    (hinv : ∀ f ∈ G, (Function.invFun f) ∈ G)
    (hfix : ∀ f ∈ G, ∃ x, f x = x) :
    ∃ k : ℝ, ∀ f ∈ G, f k = k := by sorry
