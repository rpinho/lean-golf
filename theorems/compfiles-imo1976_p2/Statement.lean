import Mathlib

noncomputable section

namespace Imo1976P2

open Polynomial

noncomputable def P (j : ℕ) : ℝ[X] :=
  match j with
  | 0 => 0
  | 1 => X^2 - 2
  | j+2 => (P 1).comp (P (j+1))

theorem _root_.LeanGolf.compfiles.imo1976_p2 (n : ℕ) (npos : 0 < n) :
    (∀ (r : ℂ), r ∈ aroots (P n - X) ℂ → r.im = 0) ∧ (aroots (P n - X) ℂ).Nodup := by sorry
