import Mathlib.Algebra.Ring.Identities
import Mathlib.Data.Int.NatPrime
import Mathlib.Tactic.Linarith
import Mathlib.Data.Set.Finite.Basic

open Int Nat

namespace Imo1969P1

theorem _root_.LeanGolf.compfiles.imo1969_p1 : Set.Infinite {a : ℕ | ∀ n : ℕ, ¬Nat.Prime (n ^ 4 + a)} := by sorry
