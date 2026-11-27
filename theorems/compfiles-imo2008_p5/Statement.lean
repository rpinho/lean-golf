import Mathlib.Tactic
import Mathlib.Data.Set.Card

noncomputable section

public section

namespace Imo2008P5

abbrev Sequence (n k : ℕ) := Fin k → Fin (2 * n)

abbrev NSequence (n k : ℕ) (f : Sequence n k) : Prop :=
  (∀ i < n, Odd (Nat.card { j | f j = i })) ∧
  (∀ i, n ≤ i → i < 2 * n → Even (Nat.card { j | f j = i }))

abbrev MSequence (n k : ℕ) (f : Sequence n k) : Prop :=
  NSequence n k f ∧
  (∀ i : Fin (2 * n), n ≤ i → ∀ j : Fin k, f j ≠ i)

end Imo2008P5

end

public section

namespace Imo2008P5

abbrev solution (n k : ℕ) : ℚ := 2 ^ (k - n)

theorem _root_.LeanGolf.compfiles.imo2008_p5 (n k : ℕ) (hn : 0 < n)
    (hnk : n ≤ k) (he : Even (k - n))
    : Set.ncard { f | MSequence n k f } * solution n k = Set.ncard { f | NSequence n k f } := by sorry
