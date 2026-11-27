import Mathlib.Algebra.CharP.Defs
import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.Data.Nat.Factorization.Defs
import Mathlib.Order.Lattice.Nat
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Linarith.Lemmas
import Mathlib.Tactic.NormNum.DivMod
import Mathlib.Tactic.Positivity.Core
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Ring.Basic
import Mathlib.Tactic.Zify

noncomputable section

namespace Usa2006P5

noncomputable def nu (x : ℤ) : ℕ := x.natAbs.factorization 2

def ValidPath : ℤ → List ℕ → Prop
  | _, [] => True
  | x, s :: ss => (s = 1 ∨ s = 2 ^ (nu x + 1)) ∧ ValidPath (x + (s : ℤ)) ss

def Reachable (m : ℤ) (j : ℕ) : Prop :=
  ∃ ss : List ℕ, ValidPath 1 ss ∧ (1 : ℤ) + (ss.sum : ℤ) = m ∧ ss.length = j

noncomputable def minJumps (m : ℤ) : ℕ := sInf { j | Reachable m j }

theorem _root_.LeanGolf.compfiles.usa2006_p5 (k : ℕ) (hk : 2 ≤ k) (i : ℕ) :
    minJumps ((2 : ℤ) ^ i * (k : ℤ)) > minJumps ((2 : ℤ) ^ i) := by sorry
