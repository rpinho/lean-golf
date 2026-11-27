import Mathlib.Analysis.Normed.Ring.Lemmas
import Mathlib.RingTheory.Polynomial.Vieta
import Mathlib.Tactic.GCongr
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity.Basic
import Mathlib.Tactic.Ring

noncomputable section

namespace Imo2023P3

open Polynomial

abbrev SolutionSet {k : ℕ} (hk : 2 ≤ k) : Set (ℕ+ → ℕ+) :=
  {a | ∃ a₀ d : ℕ, ∀ m : ℕ, (a ⟨m + 1, Nat.succ_pos m⟩).val = a₀ + d * m}

theorem _root_.LeanGolf.compfiles.imo2023_p3_imo2023p3 {k : ℕ} (hk : 2 ≤ k) (a : ℕ+ → ℕ+) :
    a ∈ SolutionSet hk ↔
    (∃ P : Polynomial ℤ, P.Monic ∧ P.degree = k ∧
     (∀ n, n ≤ k → 0 ≤ P.coeff n) ∧
      ∀ n : ℕ+,
        P.eval ((a n) : ℤ) =
        ∏ i ∈ Finset.range k, a ⟨n + i + 1, Nat.succ_pos _⟩) := by sorry
