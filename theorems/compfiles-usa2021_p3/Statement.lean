import Mathlib.Analysis.CStarAlgebra.Classes
import Mathlib.RingTheory.RootsOfUnity.Complex
import Mathlib.RingTheory.SimpleRing.Principal

noncomputable section

namespace Usa2021P3

abbrev answer : ℕ → Prop := fun n ↦ 3 ∣ n

abbrev Board := Finset (ℕ × ℕ)

def trominoCells (i j : ℕ) : Finset (ℕ × ℕ) := {(i, j), (i + 1, j), (i + 1, j + 1)}

inductive Step (n : ℕ) : Board → Board → Prop
  | tromino {b : Board} {i j : ℕ} (hi : i + 1 < n) (hj : j + 1 < n)
      (h₁ : (i, j) ∉ b) (h₂ : (i + 1, j) ∉ b) (h₃ : (i + 1, j + 1) ∉ b) :
      Step n b (b ∪ trominoCells i j)
  | clearRow {b : Board} (r : ℕ) (hfull : Finset.range n ×ˢ {r} ⊆ b) :
      Step n b (b \ Finset.range n ×ˢ {r})
  | clearCol {b : Board} (c : ℕ) (hfull : {c} ×ˢ Finset.range n ⊆ b) :
      Step n b (b \ {c} ×ˢ Finset.range n)

inductive Reach (n : ℕ) : Board → Board → Prop
  | refl (b : Board) : Reach n b b
  | tail {b b' b'' : Board} : Reach n b b' → Step n b' b'' → Reach n b b''

def Solvable (n : ℕ) : Prop := ∃ b, Step n ∅ b ∧ Reach n b ∅

theorem _root_.LeanGolf.compfiles.usa2021_p3 (n : ℕ) (hn : 2 ≤ n) : Solvable n ↔ answer n := by sorry
