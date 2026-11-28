import Mathlib.Tactic

theorem _root_.LeanGolf.compfiles.imo1967_p5 (a : Fin 8 → ℝ)
    (h₁ : Set.Infinite {n | ∑ i, a i ^ n = 0})
    (h₂ : ¬∀ i, a i = 0) :
    solution a = {n | ∑ i, a i ^ n = 0} := by
  classical
  have ho (n : ℕ) (h : ∑ i, a i ^ n = 0) : Odd n := by
    rw [← Nat.not_even_iff_odd]
    intro he
    obtain ⟨i,hi⟩ := not_forall.mp h₂
    have H := Finset.single_le_sum (f := fun i => a i ^ n) (fun j _ => he.pow_nonneg (a j)) (Finset.mem_univ i)
    rw [h] at H
    exact pow_ne_zero _ hi (le_antisymm H (he.pow_nonneg _))
  let s := Finset.univ.image (fun i => (a i)^2)
  let c (b : ℝ) := ∑ i ∈ Finset.univ.filter (fun i => a i ^ 2 = b), a i
  let u := s.filter (fun b => c b ≠ 0)
  have hg (k : ℕ) : ∑ i, a i ^ (2*k+1) = ∑ b ∈ u, c b * b ^ k := by
    change _ = ∑ b ∈ s.filter _, _
    rw [Finset.sum_filter, ← Finset.sum_fiberwise_of_maps_to (g := fun i => a i ^ 2)
      (t := s) (fun i _ => Finset.mem_image_of_mem _ (Finset.mem_univ i)) (fun i => a i ^ (2*k+1))]
    apply Finset.sum_congr rfl
    intro b _
    have hb : ∑ i ∈ Finset.univ.filter (fun i => a i ^ 2 = b), a i ^ (2*k+1) = c b * b^k := by
      unfold c
      rw [Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro i hi
      rw [pow_succ, pow_mul, (Finset.mem_filter.mp hi).2, mul_comm]
    by_cases h : c b = 0 <;> simp [h,hb]
  have hu : u = ∅ := by
    by_contra h
    have hu := Finset.nonempty_iff_ne_empty.mpr h
    let m := u.max' hu
    have hm : m ∈ u := Finset.max'_mem _ _
    have hc := (Finset.mem_filter.mp hm).2
    have hp (b : ℝ) (hb : b ∈ u) : 0 ≤ b := by
      obtain ⟨i,_,rfl⟩ := Finset.mem_image.mp (Finset.mem_filter.mp hb).1
      positivity
    have hmp : 0 < m := by
      refine lt_of_le_of_ne (hp m hm) ?_
      intro e
      exact hc (Finset.sum_eq_zero fun i hi => by nlinarith [(Finset.mem_filter.mp hi).2])
    have ht : Filter.Tendsto
        (fun k : ℕ => (∑ b ∈ u.erase m, c b * (b/m)^k) + c m) Filter.atTop (nhds (c m)) := by
      have H := tendsto_finsetSum (u.erase m) (f := fun b k => c b * (b/m)^k)
        (a := fun _ => 0) (by
          intro b hb
          obtain ⟨hne,hbu⟩ := Finset.mem_erase.mp hb
          have hlt := lt_of_le_of_ne (Finset.le_max' _ _ hbu) hne
          simpa using (tendsto_pow_atTop_nhds_zero_of_lt_one (div_nonneg (hp b hbu) hmp.le)
            ((div_lt_one hmp).2 hlt)).const_mul (c b))
      simpa using H.add tendsto_const_nhds
    obtain ⟨K,hK⟩ := Filter.eventually_atTop.mp (ht.eventually_ne hc)
    obtain ⟨n,hn,hnK⟩ := h₁.exists_notMem_finset (Finset.range (2*K))
    change ∑ i, a i ^ n = 0 at hn
    rw [Finset.mem_range] at hnK
    obtain ⟨k,rfl⟩ := ho n hn
    apply hK k (by omega)
    calc
      _ = ∑ b ∈ u, c b * (b/m)^k := by
        rw [← Finset.sum_erase_add u (fun b => c b * (b/m)^k) hm]
        simp [hmp.ne']
      _ = (∑ b ∈ u, c b * b^k) / m^k := by simp [div_pow,Finset.sum_div,mul_div_assoc]
      _ = 0 := by rw [← hg, hn, zero_div]
  ext n
  change Odd n ↔ ∑ i, a i ^ n = 0
  refine ⟨?_,ho n⟩
  rintro ⟨k,rfl⟩
  simp [hg,hu]
