import Mathlib.Tactic

theorem _root_.LeanGolf.compfiles.imo1996_p3 (f : ℕ → ℕ) :
    f ∈ SolutionSet ↔ ∀ m n, f (m + f n) = f (f m) + f n := by
  constructor
  · rintro ⟨k,g,h,rfl⟩ m n
    by_cases hk : k=0
    · simp [hk]
    have hk' : 0<k := by lia
    simp only [← Nat.add_mul]
    simp [Nat.add_mul_div_right,h,hk',Nat.add_assoc]; omega
  · intro H
    have f0 : f 0=0 := by have := H 0 0; simp_all
    have I (a) : f (f a)=f a := by simpa [f0] using H 0 a
    by_cases Z : ∀ i,f i=0
    · exact ⟨0,fun _ => 0,rfl,by funext i; simp [Z]⟩
    have ex : ∃ k, 0<k ∧ f k=k := by
      obtain ⟨i,hi⟩ := not_forall.mp Z
      exact ⟨f i,by lia,I i⟩
    let k := Nat.find ex
    obtain ⟨kp,kf⟩ := Nat.find_spec ex
    change f k=k at kf
    change 0<k at kp
    have shift (a b) : f (a+b*k)=f a+b*k := by
      induction b with
      | zero => simp
      | succ b ih =>
        have e := H (a+b*k) k
        rw [I,kf,ih] at e
        simpa [Nat.succ_mul,Nat.add_assoc] using e
    have div (a) : f a = f (a%k)+a/k*k := by
      have := shift (a%k) (a/k)
      simpa [Nat.mul_comm,Nat.mod_add_div] using this
    have dvd (a) : f a%k=0 := by
      have d := div (f a)
      have e := Nat.mod_add_div (f a) k
      rw [Nat.mul_comm k] at e
      rw [I] at d
      have fixed : f (f a%k)=f a%k := by omega
      by_contra! hh
      exact Nat.find_min ex (show f a%k < Nat.find ex from Nat.mod_lt _ kp) ⟨Nat.pos_of_ne_zero hh,fixed⟩
    refine ⟨k,fun i => f i/k,by simp [f0],?_⟩
    funext a
    have e := Nat.mod_add_div (f (a%k)) k
    rw [dvd,Nat.zero_add,Nat.mul_comm] at e
    rw [e,add_comm,← div]
