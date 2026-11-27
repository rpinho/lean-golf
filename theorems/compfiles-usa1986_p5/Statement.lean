import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Combinatorics.Enumerative.Partition.Basic

namespace Usa1986P5

theorem _root_.LeanGolf.compfiles.usa1986_p5 (n : ℕ) :
    ∑ p : Nat.Partition n, p.parts.count 1 =
      ∑ p : Nat.Partition n, p.parts.toFinset.card := by sorry
