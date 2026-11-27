import Mathlib.FieldTheory.Finite.Basic

theorem LeanGolf.fermat_little {p : ℕ} [Fact p.Prime] {a : ZMod p} (ha : a ≠ 0) : a ^ (p - 1) = 1 := by
  let u := Units.mk0 a ha
  have h := pow_card_eq_one (x := u)
  rw [ZMod.card_units p] at h
  simpa [u] using congrArg (fun v : (ZMod p)ˣ => (v : ZMod p)) h
