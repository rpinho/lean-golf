import Mathlib.Tactic

theorem _root_.LeanGolf.compfiles.usa1982_p4 :
    ∃ k : ℕ, 0 < k ∧ ∀ n : ℕ, ¬ Prime (k * (2 ^ n) + 1) := by
  refine ⟨78557,by decide,fun n h => ?_⟩
  have H : ∀ r : Fin 36, ∃ p : Fin 74, 1 < p.val ∧
      (2^36 ≡ 1 [MOD p.val]) ∧ p.val ∣ 78557*2^r.val+1 := by decide +kernel
  obtain ⟨p,h₁,h₂,h₃⟩ := H ⟨n%36,by omega⟩
  have E := (h₂.pow (n/36)).mul_left (2^(n%36))
  rw [←pow_mul,←pow_add,Nat.mod_add_div,one_pow,mul_one] at E
  have := p.isLt
  have : 0 < (2:ℕ)^n := by positivity
  have := (Nat.dvd_prime (Nat.prime_iff.2 h)).1 ((((E.mul_left 78557).add_right 1).dvd_iff (dvd_refl _)).2 h₃)
  omega
