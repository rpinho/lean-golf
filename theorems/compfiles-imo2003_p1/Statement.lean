import Mathlib.Tactic

noncomputable section

namespace Imo2003P1

abbrev S := Finset.Icc 1 1000000

theorem _root_.LeanGolf.compfiles.imo2003_p1 (A : Finset ℕ) (AS : A ⊆ S) (Acard : A.card = 101) :
    ∃ t ⊆ S, t.card = 100 ∧ ∀ x ∈ t, ∀ y ∈ t, x ≠ y → Disjoint {x + a | a ∈ A} {y + a | a ∈ A} := by sorry
