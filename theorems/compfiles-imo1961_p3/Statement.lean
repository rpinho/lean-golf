import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Tactic

noncomputable section

namespace Imo1961P3

open Real

abbrev solutionSet (n : ℕ+) : Set ℝ :=
 { x | (∃ k : ℤ, k * π = x) ∧ Even n.val ∨ (∃ k : ℤ, k * (2 * π) = x) ∧ Odd n.val ∨
          (∃ k : ℤ, -(π / 2) + k * (2 * π) = x) ∧ Odd n.val }

theorem _root_.LeanGolf.compfiles.imo1961_p3 {n : ℕ} {x : ℝ} (npos : 0 < n) :
    x ∈ solutionSet ⟨n, npos⟩ ↔
    (cos x) ^ n - (sin x) ^ n = 1 := by sorry
