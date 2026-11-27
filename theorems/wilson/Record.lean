import Mathlib.NumberTheory.Wilson

theorem LeanGolf.wilson {n : ℕ} (h : n ≠ 1) : n.Prime ↔ ((n - 1).factorial : ZMod n) = -1 := ⟨fun hp => (haveI : Fact n.Prime := ⟨hp⟩; ZMod.wilsons_lemma n),
  fun hf => Nat.prime_of_fac_equiv_neg_one hf h⟩
