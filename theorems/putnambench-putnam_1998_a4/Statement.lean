import Mathlib

noncomputable section

abbrev putnam_1998_a4_solution : Set ℕ :=
  {n | n ≡ 1 [MOD 6]}

theorem LeanGolf.putnambench.putnam_1998_a4
    (A : ℕ → List ℕ)
    (hA1 : A 1 = [0])
    (hA2 : A 2 = [1])
    (hA : ∀ n > 0, A (n + 2) = A (n + 1) ++ A n) :
    {n | 1 ≤ n ∧ 11 ∣ Nat.ofDigits 10 (A n).reverse} = putnam_1998_a4_solution := by sorry
