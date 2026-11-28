import Mathlib

theorem LeanGolf.proofnet.ireland_rosen_exercise_4_4 {p t: ℕ} (hp0 : p.Prime) (hp1 : p = 4*t + 1)
  (a : ZMod p) :
  IsPrimitiveRoot a p ↔ IsPrimitiveRoot (-a) p := by have : Fact p.Prime := ⟨hp0⟩; constructor <;> intro h <;> have e := h.pow_eq_one <;> rw [ZMod.pow_card] at e <;> simp_all [hp0.ne_one]
