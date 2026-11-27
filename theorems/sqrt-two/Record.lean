import Mathlib.NumberTheory.Real.Irrational

theorem LeanGolf.sqrt_two : Irrational (Real.sqrt 2) := (irrational_sqrt_ofNat_iff (n := 2)).2 Nat.prime_two.not_isSquare
