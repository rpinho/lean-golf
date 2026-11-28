import Mathlib

theorem LeanGolf.proofnet.munkres_exercise_21_6b
  (f : ℕ → I → ℝ )
  (h : ∀ x n, f n x = x ^ n) :
  ¬ ∃ f₀, TendstoUniformly f f₀ atTop := by
  rintro ⟨g,hg⟩
  obtain ⟨N,hN⟩ := eventually_atTop.1 ((Metric.tendstoUniformly_iff.1 hg) (1/2) (by norm_num))
  obtain ⟨x,hx,H⟩ := intermediate_value_Icc (zero_le_one : (0:ℝ)≤1) (continuous_id.pow (N+1)).continuousOn
    (show (1/2:ℝ) ∈ Icc (0^(N+1)) (1^(N+1)) by norm_num [pow_succ])
  have xl : x < 1 := lt_of_le_of_ne hx.2 (by intro e; norm_num [e] at H)
  let y : I := ⟨x,hx⟩
  have gz : g y = 0 := tendsto_nhds_unique (hg.tendsto_at y)
    (by simpa only [h] using tendsto_pow_atTop_nhds_zero_of_lt_one hx.1 xl)
  have K := hN (N+1) (by omega) y
  rw [gz,h,show (y:ℝ)^(N+1) = 1/2 from H] at K
  norm_num [Real.dist_eq] at K
