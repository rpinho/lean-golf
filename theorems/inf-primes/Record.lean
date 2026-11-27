import Mathlib.Data.Nat.Prime.Infinite

theorem LeanGolf.inf_primes (n : ℕ) : ∃ p, n ≤ p ∧ Nat.Prime p := by
  let m := n.factorial + 1
  have hm : m ≠ 1 := by
    have := Nat.factorial_pos n
    omega
  let p := m.minFac
  have hp : p.Prime := Nat.minFac_prime hm
  refine ⟨p, ?_, hp⟩
  by_contra h
  have hd := Nat.dvd_factorial hp.pos (Nat.le_of_lt (Nat.lt_of_not_ge h))
  have hm' : p ∣ n.factorial + 1 := Nat.minFac_dvd m
  exact hp.not_dvd_one ((Nat.dvd_add_iff_right hd).mpr hm')
