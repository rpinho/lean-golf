import Mathlib.Data.Nat.Prime.Basic

theorem LeanGolf.euclid_lemma {p m n : ℕ} (pp : p.Prime) : p ∣ m * n ↔ p ∣ m ∨ p ∣ n := by
  constructor
  · intro h
    by_cases hm : p ∣ m
    · exact Or.inl hm
    · exact Or.inr ((pp.coprime_iff_not_dvd.mpr hm).dvd_of_dvd_mul_left h)
  · rintro (hm | hn)
    · exact Nat.dvd_mul_right_of_dvd hm n
    · exact Nat.dvd_mul_left_of_dvd hn m
