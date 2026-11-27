import Mathlib.Tactic

namespace Usa1998P5

theorem _root_.LeanGolf.compfiles.usa1998_p5 (n : ℕ) (_hn : 2 ≤ n) :
    ∃ S : Finset ℤ,
       S.card = n ∧
       ∀ a ∈ S, ∀ b ∈ S, a ≠ b → (a - b)^2 ∣ a * b := by sorry
