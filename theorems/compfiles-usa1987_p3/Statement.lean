import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib

namespace Usa1987P3

open Polynomial

theorem _root_.LeanGolf.compfiles.usa1987_p3
    (S : Set (Polynomial ℝ))
    (_hX : Polynomial.X ∈ S)
    (_hmul : ∀ r ∈ S, Polynomial.X * r ∈ S)
    (_hcomb : ∀ r ∈ S, Polynomial.X + (1 - Polynomial.X) * r ∈ S)
    (hmin : ∀ T : Set (Polynomial ℝ), Polynomial.X ∈ T →
        (∀ r ∈ T, Polynomial.X * r ∈ T) →
        (∀ r ∈ T, Polynomial.X + (1 - Polynomial.X) * r ∈ T) → S ⊆ T)
    {r s : Polynomial ℝ} (hr : r ∈ S) (hs : s ∈ S) (hne : r ≠ s)
    {x : ℝ} (hx0 : 0 < x) (hx1 : x < 1) :
    r.eval x ≠ s.eval x := by sorry
