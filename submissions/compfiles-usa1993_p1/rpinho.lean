import Mathlib.Tactic

theorem _root_.LeanGolf.compfiles.usa1993_p1 (n : ℕ) (hn : 2 ≤ n) (a b : ℝ) (ha : 0 < a) (hb : 0 < b)
    (han : a^n = a + 1) (hbn : b^(2 * n) = b + 3 * a) :
    if a_is_larger n then b < a else a < b := by
  change b<a
  by_contra! H
  have A : a≠1 := by rintro rfl; norm_num at han
  have s : 4*a<a^(2*n) := by rw [Nat.mul_comm,pow_mul,han]; nlinarith [sq_pos_of_ne_zero (sub_ne_zero.mpr A)]
  cases e:2*n with
  | zero => omega
  | succ k =>
    rw [e,pow_succ] at s hbn
    have u := (mul_lt_mul_iff_left₀ ha).mp s
    linarith [mul_lt_mul_of_pos_right (u.trans_le (pow_le_pow_left₀ ha.le H k)) hb]
