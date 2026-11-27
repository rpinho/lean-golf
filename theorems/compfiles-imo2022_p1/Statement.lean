import Mathlib

noncomputable section

open scoped Finset

namespace Imo2022P1

inductive Coin : Type where
  | A : Coin
  | B : Coin
deriving DecidableEq

abbrev Row (n : ℕ) : Type := Fin (2 * n) → Coin

def Row.valid {n : ℕ} (c : Row n) : Prop := #{i | c i = Coin.A} = n

def Row.chainLeft {n : ℕ} (c : Row n) (k : Fin (2 * n)) : Fin (2 * n) :=
  {j ∈ Finset.Iic k | ∀ i, j ≤ i → i ≤ k → c i = c k}.min' (show Finset.Nonempty _ from ⟨k, by
    simp only [Finset.mem_filter, Finset.mem_Iic, le_refl, true_and]
    rintro i hki hik
    rw [le_antisymm hki hik]⟩)

def Row.chainRight {n : ℕ} (c : Row n) (k : Fin (2 * n)) : Fin (2 * n) :=
  {j ∈ Finset.Ici k | ∀ i, k ≤ i → i ≤ j → c i = c k}.max' (show Finset.Nonempty _ from ⟨k, by
    simp only [Finset.mem_filter, Finset.mem_Ici, le_refl, true_and]
    rintro i hki hik
    rw [le_antisymm hki hik]⟩)

def Row.move {n : ℕ} (c : Row n) (a b : Fin (2 * n)) : Row n :=
  fun i ↦ if b < i then c i else c ⟨(((i : ℕ) + (a : ℕ)) % ((b : ℕ) + 1)),
    (Nat.mod_lt _ (by lia)).trans_le (by lia)⟩

def Row.operation {n : ℕ} (k : Fin (2 * n)) (c : Row n) : Row n :=
  c.move (c.chainLeft k) (c.chainRight k)

def Row.operationOneBased {n k : ℕ} (hk1 : 1 ≤ k) (hkn : k ≤ 2 * n) (c : Row n) :
    Row n :=
  c.operation ⟨k - 1, by lia⟩

def Row.leftmostNSame {n : ℕ} (c : Row n) := ∀ j₁ j₂ : Fin (2 * n),
  (j₁ : ℕ) < n → (j₂ : ℕ) < n → c j₁ = c j₂

universe u

def List.chainLeft {α : Type u} [DecidableEq α] (l : List α) (k : Fin l.length) : Fin l.length :=
  {j ∈ Finset.Iic k | ∀ i, j ≤ i → i ≤ k → l.get i = l.get k}.min' (show Finset.Nonempty _ from ⟨k, by
    simp only [Finset.mem_filter, Finset.mem_Iic, le_refl, true_and]
    rintro i hki hik
    rw [le_antisymm hki hik]⟩)

def List.chainRight {α : Type u} [DecidableEq α] (l : List α) (k : Fin l.length) : Fin l.length :=
  {j ∈ Finset.Ici k | ∀ i, k ≤ i → i ≤ j → l.get i = l.get k}.max' (show Finset.Nonempty _ from ⟨k, by
    simp only [Finset.mem_filter, Finset.mem_Ici, le_refl, true_and]
    rintro i hki hik
    rw [le_antisymm hki hik]⟩)

def List.move {α : Type u} (a b : ℕ): List α → List α
  := fun l ↦ (l.drop a).take (b + 1 - a) ++ l.take a ++ l.drop (b + 1)

def List.operation {α : Type u} [DecidableEq α] (l : List α) (k : Fin l.length) : List α :=
  List.move (List.chainLeft l k) (List.chainRight l k) l

def List.operationOneBased {α : Type u} [DecidableEq α] (l : List α) {k : ℕ} (hk1 : 1 ≤ k) (hkn : k ≤ l.length):
    List α :=
  List.operation l ⟨k - 1, by lia⟩

abbrev answer : Set (ℕ × ℕ) := {(n, k) : ℕ × ℕ | 0 < n ∧ n ≤ k ∧ k ≤ 3 * n ⌈/⌉ 2}

theorem _root_.LeanGolf.compfiles.imo2022_p1 : {(n, k) | ∃ hk1 : 1 ≤ k, ∃ hkn : k ≤ 2 * n, ∀ c : Row n, c.valid →
    ∃ i, ((Row.operationOneBased hk1 hkn)^[i] c).leftmostNSame} =
    answer := by sorry
