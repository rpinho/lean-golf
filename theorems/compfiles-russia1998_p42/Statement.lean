import Mathlib

namespace Russia1998P42

variable (star : ℝ → ℝ → ℝ)

local infixl:80 " ⋆ " => star

theorem _root_.LeanGolf.compfiles.russia1998_p42
  (stardef : ∀ a b c, a ⋆ b ⋆ c = a + b + c) :
  (∀ a b, a ⋆ b = a + b) := by sorry
