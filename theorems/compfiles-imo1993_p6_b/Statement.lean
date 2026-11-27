import Mathlib.Tactic

noncomputable section

namespace Imo1993P6

open scoped Fin.NatCast

abbrev State (n : ℕ) := (Fin n → Bool) × Fin n

def step {n : ℕ} [NeZero n] (s : State n) : State n :=
  (Function.update s.1 s.2 (if s.1 (s.2 - 1) then !s.1 s.2 else s.1 s.2), s.2 + 1)

abbrev initial (n : ℕ) [NeZero n] : State n := (fun _ => true, 0)

abbrev lampsAfter (n : ℕ) [NeZero n] (t : ℕ) : Fin n → Bool :=
  (step^[t] (initial n)).1

theorem _root_.LeanGolf.compfiles.imo1993_p6_b (n k : ℕ) [NeZero n] (hn : n = 2 ^ k) (hk : 0 < k) :
    ∀ i : Fin n, lampsAfter n (n ^ 2 - 1) i = true := by sorry
