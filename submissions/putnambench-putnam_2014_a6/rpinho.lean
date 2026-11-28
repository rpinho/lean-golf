import Mathlib

theorem LeanGolf.putnambench.putnam_2014_a6
(n : ℕ)
(kex : ℕ → Prop)
(npos : n > 0)
(hkex : ∀ k ≥ 1, kex k = ∃ M N : Fin k → Matrix (Fin n) (Fin n) ℝ, ∀ i j : Fin k, ((∃ p : Fin n, (M i * N j) p p = 0) ↔ i ≠ j))
: (putnam_2014_a6_solution n ≥ 1 ∧ kex (putnam_2014_a6_solution n)) ∧ (∀ k ≥ 1, kex k → k ≤ putnam_2014_a6_solution n) := by
  classical
  change (1 ≤ n^n ∧ kex (n^n)) ∧ _
  have hp : 1≤n^n := Nat.one_le_pow _ _ npos
  constructor
  · refine ⟨hp,(hkex _ hp).mpr ?_⟩
    let e : Fin (n^n) ≃ (Fin n → Fin n) := Fintype.equivOfCardEq (by simp)
    let M := fun i : Fin (n^n) => Matrix.of (fun p q : Fin n => if e i p=q then (1:ℝ) else 0)
    refine ⟨M,fun i => (M i).transpose,?_⟩
    intro i j
    have d (p) : (M i * (M j).transpose) p p = if e i p=e j p then 1 else 0 := by
      simp [Matrix.mul_apply,M,eq_comm]
    simp [d,← not_forall,← funext_iff]
  · intro k hk K
    obtain ⟨M,N,H⟩ := (hkex k hk).mp K
    let X (i:Fin k) (s:Fin n → Fin n) := ∏ p,M i p (s p)
    let Y (i:Fin k) (s:Fin n → Fin n) := ∏ p,N i (s p) p
    have dot (i j) : (∑ s,X i s*Y j s)=∏ p,(M i*N j) p p := by
      simp only [X,Y,← Finset.prod_mul_distrib,Matrix.mul_apply]
      rw [Finset.prod_univ_sum]; simp
    have d (i j) : (∑ s,X i s*Y j s)=0 ↔ i≠j := by simpa [dot,Finset.prod_eq_zero_iff] using H i j
    have line : LinearIndependent ℝ X := by
      rw [Fintype.linearIndependent_iff]
      intro w hw i
      have E (s) : ∑ j,w j*X j s=0 := by simpa using congrFun hw s
      have e : ∑ j,w j*(∑ s,X j s*Y i s)=0 := by
        simp_rw [Finset.mul_sum]
        rw [Finset.sum_comm]
        apply Finset.sum_eq_zero
        intro s _
        simpa [← mul_assoc,← Finset.sum_mul] using congrArg (fun x => x*Y i s) (E s)
      rw [Finset.sum_eq_single i (fun j _ h => mul_eq_zero_of_right _ ((d j i).2 h)) (by simp)] at e
      exact (mul_eq_zero.mp e).resolve_right (by simp [d])
    simpa [putnam_2014_a6_solution] using line.fintype_card_le_finrank
