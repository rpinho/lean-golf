import Mathlib

noncomputable section

namespace Imo2011P1

def pairCount (A : Finset ℕ) : ℕ :=
  ((A.powersetCard 2).filter fun p ↦ (∑ x ∈ p, x) ∣ ∑ x ∈ A, x).card

abbrev SolutionSet : Set (Finset ℕ) :=
  { A | ∃ c : ℕ, 0 < c ∧
        (A = {c, 5 * c, 7 * c, 11 * c} ∨ A = {c, 11 * c, 19 * c, 29 * c}) }

theorem _root_.LeanGolf.compfiles.imo2011_p1 (A : Finset ℕ) (hA : A.card = 4) (hApos : ∀ a ∈ A, 0 < a) :
    A ∈ SolutionSet ↔
      ∀ B : Finset ℕ, B.card = 4 → (∀ b ∈ B, 0 < b) →
        pairCount B ≤ pairCount A := by sorry
