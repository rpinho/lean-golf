import Mathlib

theorem LeanGolf.putnambench.putnam_2000_a1
(A : ℝ)
(Apos : A > 0)
: {S : ℝ |
    ∃ x : ℕ → ℝ,
      (∀ j : ℕ, x j > 0) ∧
      (∑' j : ℕ, x j) = A ∧
      (∑' j : ℕ, (x j) ^ 2) = S}
  = putnam_2000_a1_solution A := by
  ext S
  change (∃ x:ℕ→ℝ, _ ∧ _ ∧ _) ↔ 0<S ∧ S<A^2
  constructor
  · rintro ⟨x,hx,hA,rfl⟩
    have sm : Summable x := by by_contra h; rw [tsum_eq_zero_of_not_summable h] at hA; linarith
    have le (i) : x i ≤ A := hA ▸ sm.le_tsum i (fun j _ => (hx j).le)
    have B i : x i^2≤A*x i := by rw [sq]; gcongr <;> grind
    have sm' : Summable (fun i => x i^2) := Summable.of_nonneg_of_le (fun i => sq_nonneg _) B (sm.mul_left A)
    have lt : x 0 < A := by
      have z := sm.sum_le_tsum ({0,1}:Finset ℕ) (fun i _ => (hx i).le)
      simp [hA] at z
      linarith [hx 1]
    constructor
    · exact lt_of_lt_of_le (sq_pos_of_pos (hx 0)) (sm'.le_tsum 0 (fun j _ => sq_nonneg _))
    · have h := sm'.tsum_lt_tsum (i:=0) B (show x 0^2<A*x 0 by rw [sq]; gcongr <;> grind) (sm.mul_left A)
      simpa [tsum_mul_left,hA,pow_two] using h
  · rintro ⟨hS,hSA⟩
    let r := (A^2-S)/(A^2+S)
    have hr : 0<r := by dsimp [r]; positivity
    have hr' : r<1 := by dsimp [r]; apply (div_lt_one (by positivity)).2; linarith
    let c := A*(1-r)
    refine ⟨fun i => c*r^i,fun i => by dsimp [c]; positivity,?_,?_⟩
    · rw [tsum_mul_left,tsum_geometric_of_lt_one hr.le hr']
      dsimp [c]
      field_simp [ne_of_gt (sub_pos.mpr hr')]
    · have e (j:ℕ) : (c*r^j)^2=c^2*(r^2)^j := by ring
      simp_rw [e]
      have hh : r^2<1 := by exact pow_lt_one₀ hr.le hr' (by decide)
      rw [tsum_mul_left,tsum_geometric_of_lt_one (sq_nonneg _) hh]
      field_simp [ne_of_gt (sub_pos.mpr hh)]
      dsimp [c,r]
      field_simp
      ring
