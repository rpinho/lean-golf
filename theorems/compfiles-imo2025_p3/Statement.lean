import Mathlib.Tactic
import Mathlib.Data.ENat.Basic
import Mathlib.NumberTheory.LSeries.PrimesInAP
import Mathlib.NumberTheory.Multiplicity
import Mathlib.Data.Nat.Basic
import Mathlib
import Mathlib.Order.Bounds.Basic

noncomputable section

open Int

def Bonza (f : ℕ+ → ℕ+) : Prop :=
  ∀ a b : ℕ+,
    (f a : Int) ∣ ((b : Int) ^ (a: ℕ) - (f b : Int) ^ ((f a): ℕ))

def is_valid_c (c : ℝ) : Prop :=
  ∀ (f : ℕ+ → ℕ+), Bonza f → ∀ n, (f n : ℝ) ≤ c * (n : ℝ)

abbrev answer : ℝ := 4

theorem LeanGolf.compfiles.imo2025_p3 :
  IsLeast {c: ℝ | is_valid_c c} answer := by sorry
