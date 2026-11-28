import Mathlib

theorem LeanGolf.compfiles.imo1972_p1 (S : Finset ℕ) (h₀ : S.card = 10) (h₁ : S ⊆ Finset.Ico 10 100) :
    ∃ S₁ S₂ : Finset ℕ,
      -- while the text says "subset", it appears to mean "nonempty subset"
      S₁.Nonempty ∧ S₁ ⊆ S ∧
      S₂.Nonempty ∧ S₂ ⊆ S ∧
      Disjoint S₁ S₂ ∧ ∑ x ∈ S₁, x = ∑ x ∈ S₂, x := by sorry
