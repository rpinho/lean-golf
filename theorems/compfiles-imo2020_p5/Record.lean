import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

theorem _root_.LeanGolf.compfiles.imo2020_p5 (n : ℕ) :
    n ∈ SolutionSet ↔
    (1 < n ∧
     (∀ f : Fin n → ℕ+,
        (Pairwise fun a b ↦ ∃ s : Finset (Fin n),
          s.Nonempty ∧ geometric_mean f s = (((f a):ℝ) + f b) / 2)
        → ∃ y, ∀ a, f a = y )) := by
  classical
  change 1<n ↔ _
  refine ⟨fun hn => ⟨hn,?_⟩,And.left⟩
  intro f H
  let d := Finset.univ.gcd (fun i => (f i:ℕ))
  let g := fun i => (f i:ℕ)/d
  have dv (i) : d ∣ (f i:ℕ) := Finset.gcd_dvd (Finset.mem_univ i)
  have eqf (i) : (f i:ℕ)=g i*d := (Nat.div_mul_cancel (dv i)).symm
  let a0 : Fin n := ⟨0,by lia⟩
  have dp : 0<d := Nat.pos_of_dvd_of_pos (dv a0) (f a0).2
  have gp (i) : 0<g i := Nat.div_pos (Nat.le_of_dvd (f i).2 (dv i)) dp
  have prop (a b) (hab:a≠b) : ∃ s:Finset (Fin n),s.Nonempty ∧ (g a+g b)^s.card=2^s.card*∏ i∈s,g i := by
    obtain ⟨s,hs,he⟩ := H hab
    refine ⟨s,hs,?_⟩
    have e := congrArg (fun x:ℝ => x^s.card) he
    have hn' : (s.card:ℝ)≠0 := by exact_mod_cast hs.card_pos.ne'
    dsimp [geometric_mean] at e
    rw [← Real.rpow_natCast,← Real.rpow_mul (by positivity),one_div_mul_cancel hn',Real.rpow_one,div_pow] at e
    have E : ((f a:ℕ)+(f b:ℕ))^s.card=2^s.card*∏ i∈s,(f i:ℕ) := by
      exact_mod_cast (show (((f a:ℝ)+f b)^s.card)=2^s.card*∏ i∈s,(f i:ℝ) by field_simp at e; linarith)
    simp_rw [eqf] at E
    rw [← Nat.add_mul,mul_pow,Finset.prod_mul_distrib,Finset.prod_const] at E
    exact Nat.eq_of_mul_eq_mul_right (pow_pos dp _) (by simpa [Nat.mul_assoc] using E)
  obtain ⟨a,_,ha⟩ := Finset.exists_max_image Finset.univ g ⟨a0,(by simp)⟩
  have ga : g a=1 := by
    by_contra h
    obtain ⟨p,pp,pa⟩ := Nat.exists_prime_and_dvd h
    have ex : (Finset.univ.filter (fun i => ¬p∣g i)).Nonempty := by
      simp only [Finset.filter_nonempty_iff,Finset.mem_univ,true_and]
      by_contra! h
      have D : p*d ∣ d := Finset.dvd_gcd (fun i _ => eqf i ▸ Nat.mul_dvd_mul_right (h i) _)
      have := Nat.le_of_dvd dp D
      nlinarith [Nat.mul_le_mul_right d pp.two_le]
    obtain ⟨b,hb,hmax⟩ := Finset.exists_max_image _ g ex
    have pb := (Finset.mem_filter.mp hb).2
    obtain ⟨s,hs,e⟩ := prop a b (by rintro rfl; contradiction)
    have nd : ¬p∣(g a+g b)^s.card := by
      intro h
      exact pb ((Nat.dvd_add_right pa).mp (pp.dvd_of_dvd_pow h))
    have bound (i) (hi:i∈s) : g i ≤ g b := by
      apply hmax i (Finset.mem_filter.mpr ⟨(by simp),?_⟩)
      intro h
      apply nd
      rw [e]
      exact dvd_mul_of_dvd_right (h.trans (Finset.dvd_prod_of_mem g hi)) _
    have ub := Finset.prod_le_prod' bound
    have lt : g b<g a := lt_of_le_of_ne (ha b ((by simp))) (by intro h; apply pb; rwa [h])
    apply (pow_lt_pow_left₀ (show 2*g b<g a+g b by lia) (by lia) hs.card_pos.ne').not_ge
    rw [e,mul_pow]
    gcongr
    simpa using ub
  refine ⟨f a,fun i => Subtype.ext ?_⟩
  change (f i:ℕ)=(f a:ℕ)
  rw [eqf,eqf]
  have u := ha i ((by simp))
  have v := gp i
  rw [show g i=g a by lia]
