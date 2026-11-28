import Mathlib

theorem LeanGolf.putnambench.putnam_1987_a2
    (seqind seqsize f : ℕ → ℕ)
    (hseqind : seqind 1 = 1 ∧ ∀ i ≥ 2, seqind i = seqind (i - 1) + (Nat.digits 10 (i - 1)).length)
    (hseqsize : ∀ i ≥ 1, ∀ j : Fin ((Nat.digits 10 i).length), seqsize (seqind i + j) = (Nat.digits 10 i).length)
    (hf : ∀ n : ℕ, f n = seqsize (10 ^ n)) :
    f 1987 = putnam_1987_a2_solution := by
  let L:ℕ := 10^1983
  let R:ℕ := 10^1984
  let T:ℕ := 10^1987
  have lp : 0 < L := by decide +kernel
  have len (i) (a : L ≤ i) (b : i < R) : (Nat.digits 10 i).length=1984 := by
    rw [Nat.digits_len _ _ (by decide) (by omega)]
    have := (Nat.log_eq_iff (by left; decide : 1983 ≠ 0 ∨ 1 < 10 ∧ i ≠ 0)).mpr ⟨a,b⟩
    omega
  have step (i) (h:0 < i) : seqind (i+1)=seqind i+(Nat.digits 10 i).length := by simpa using hseqind.2 (i+1) (by omega)
  have bound (i) (h:1 ≤ i) (u:i ≤ L) : seqind i ≤ 1984*i := by
    induction i with
    | zero => omega
    | succ i ih =>
      obtain rfl|hp := Nat.eq_zero_or_pos i
      · rw [hseqind.1]; decide
      rw [step i hp]
      have hi := ih hp (by omega)
      rw [Nat.digits_len _ _ (by decide) hp.ne']
      have := Nat.log_lt_of_lt_pow hp.ne' (show i < 10^1983 by change i < L; omega)
      omega
  have B : seqind L  ≤  T := le_trans (bound L (by omega) le_rfl) (by decide +kernel)
  let t := (T-seqind L)/1984
  have tlt : L+t < R := by
    have k : T+1984*L  <  1984*R := by decide +kernel
    dsimp [t]
    omega
  have idx (j) (hj:j ≤ t) : seqind (L+j)=seqind L+1984*j := by
    induction j with
    | zero => simp
    | succ j ih =>
      have e := step (L+j) (by omega)
      rw [len (L+j) (by omega) (by omega),ih (by omega)] at e
      rw [← Nat.add_assoc,e]
      omega
  let i := L+t
  have hl := len i (Nat.le_add_right ..) tlt
  let j : Fin (Nat.digits 10 i).length := ⟨(T-seqind L)%1984,by rw [hl]; omega⟩
  have hh := hseqsize i (by dsimp [i]; omega) j
  change seqsize (seqind (L+t)+(T-seqind L)%1984)=_ at hh
  rw [idx t le_rfl,hl] at hh
  rw [hf]
  convert hh using 2
  change T=_
  dsimp [t]
  omega
