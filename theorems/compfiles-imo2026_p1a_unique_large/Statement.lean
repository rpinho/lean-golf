import Mathlib.Algebra.GCDMonoid.Multiset
import Mathlib.Algebra.GCDMonoid.Nat
import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.NumberTheory.Padics.PadicVal.Basic

noncomputable section

namespace Imo2026P1

abbrev Board := Multiset ℕ

def IsInitial (B : Board) : Prop :=
  Multiset.card B = 2026 ∧ ∀ a ∈ B, 1 < a

def Move (B B' : Board) : Prop :=
  ∃ (m n : ℕ) (s : Board), 1 < m ∧ 1 < n ∧
    B = m ::ₘ n ::ₘ s ∧
    B' = Nat.gcd m n ::ₘ (Nat.lcm m n / Nat.gcd m n) ::ₘ s

def IsTerminal (B : Board) : Prop :=
  Multiset.card (B.filter (fun a => 1 < a)) ≤ 1

def HasUniqueLarge (B : Board) : Prop :=
  Multiset.card (B.filter (fun a => 1 < a)) = 1

def Reachable (B B' : Board) : Prop := Relation.ReflTransGen Move B B'

theorem _root_.LeanGolf.compfiles.imo2026_p1a_unique_large (B₀ : Board) (hB₀ : IsInitial B₀)
    (B' : Board) (hreach : Reachable B₀ B') (hterm : IsTerminal B') :
    HasUniqueLarge B' := by sorry
