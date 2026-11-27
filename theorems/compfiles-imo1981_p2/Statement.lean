import Mathlib

noncomputable section

namespace Imo1981P2

open Finset

variable (n r : ℕ)

def arith_mean (ms : Multiset ℕ) : ℚ := ms.sum / ms.card

def F : ℚ := arith_mean <| ((Icc 1 n).powersetCard r).val.map (fun s => s.min.getD 0)

open SimpleGraph

def eraseMin (s : Finset ℕ) :=
  if h : s.Nonempty then
    s.erase (s.min' h)
  else
    s

abbrev V := (powersetCard (r+1) (Icc 0 n)) ⊕ (powersetCard r (Icc 1 n))

def G : SimpleGraph (V n r) := {
  Adj u v := match (u, v) with
    | (.inl a, .inr b) | (.inr b, .inl a) => eraseMin a = b
    | _ => False
  symm := by
    grind only [swap_eq_iff]
}

instance : DecidableRel (G n r).Adj := fun u v =>
  match h : (u, v) with
  | (.inl a, .inr b) | (.inr b, .inl a) => if h' : eraseMin a = b then .isTrue (by simp_all [G]) else .isFalse (by simp_all [G])
  | (.inl a, .inl b) | (.inr b, .inr a) => .isFalse (by simp_all [G])

theorem _root_.LeanGolf.compfiles.imo1981_p2 (rpos : 1 ≤ r) (hrn : r ≤ n) : F n r = (n+1)/(r+1) := by sorry
