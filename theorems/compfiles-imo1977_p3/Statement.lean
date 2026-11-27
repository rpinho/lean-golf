import Mathlib.Tactic

noncomputable section

namespace Imo1977P3

def Vn (n : ℕ) : Set ℕ := {m | ∃ k : ℕ, 1 ≤ k ∧ m = 1 + k * n}

def Indecomposable (n : ℕ) (m : ℕ) : Prop :=
  m ∈ Vn n ∧ ¬ ∃ p q : ℕ, p ∈ Vn n ∧ q ∈ Vn n ∧ m = p * q

theorem _root_.LeanGolf.compfiles.imo1977_p3 (n : ℕ) (hn : 2 < n) :
    ∃ r ∈ Vn n, ∃ F₁ F₂ : Multiset ℕ,
      (∀ d ∈ F₁, Indecomposable n d) ∧ (∀ d ∈ F₂, Indecomposable n d) ∧
      F₁.prod = r ∧ F₂.prod = r ∧ F₁ ≠ F₂ := by sorry
