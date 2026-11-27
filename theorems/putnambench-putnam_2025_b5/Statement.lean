import Mathlib

noncomputable section

open Finset BigOperators

def modInv (p : ℕ) (k : ℕ) : ℕ := ZMod.val ((k : ZMod p)⁻¹)

def descentCount (p : ℕ) : ℕ :=
  #{k ∈ Finset.Icc 1 (p - 2) | modInv p (k + 1) < modInv p k}

theorem LeanGolf.putnambench.putnam_2025_b5
    (p : ℕ)
    (hp_prime : p.Prime)
    (hp_gt : 3 < p) :
    (p : ℚ) / 4 - 1 < descentCount p := by sorry
