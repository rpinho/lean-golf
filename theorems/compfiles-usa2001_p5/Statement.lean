import Mathlib.RingTheory.Int.Basic

namespace Usa2001P5

theorem _root_.LeanGolf.compfiles.usa2001_p5 (S : Set ℤ) (hS : ∀ x ∈ S, ∀ y ∈ S, x^2 - y ∈ S)
    (a b : ℤ) (ha : a ∈ S) (hb : b ∈ S)
    (h1 : Int.gcd a b = 1) (h2 : Int.gcd (a - 2) (b - 2) = 1) :
    S = Set.univ := by sorry
