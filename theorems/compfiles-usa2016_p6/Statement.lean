import Mathlib.Algebra.GroupWithZero.Nat
import Mathlib.Data.Finset.Option
import Mathlib.Data.Fintype.Perm
import Mathlib.Data.Fintype.Pigeonhole

noncomputable section

namespace Usa2016P6

open Finset

abbrev Arrangement (n : ℕ) := Fin (2 * n) → Fin n

def Arrangement.Valid {n : ℕ} (a : Arrangement n) : Prop :=
  ∀ ℓ : Fin n, (univ.filter fun i ↦ a i = ℓ).card = 2

abbrev Observation (n : ℕ) := Finset (Fin (2 * n)) × (Fin (2 * n) → Option (Fin n))

abbrev Strategy (n : ℕ) := List (Observation n) → Finset (Fin (2 * n))

def Strategy.Valid {n : ℕ} (σ : Strategy n) (k : ℕ) : Prop :=
  ∀ h, (σ h).card = k

def reveal {n : ℕ} (a : Arrangement n) (Q : Finset (Fin (2 * n))) :
    Fin (2 * n) → Option (Fin n) :=
  fun i ↦ if i ∈ Q then some (a i) else none

structure Wizard (n : ℕ) where
  init : Arrangement n
  perm : List (Observation n) → Finset (Fin (2 * n)) → Equiv.Perm (Fin (2 * n))

def Wizard.Valid {n : ℕ} (W : Wizard n) : Prop :=
  W.init.Valid ∧ ∀ h Q i, i ∉ Q → W.perm h Q i = i

structure PlayState (n : ℕ) where
  arr : Arrangement n
  hist : List (Observation n)
  won : Bool

def step {n : ℕ} (σ : Strategy n) (W : Wizard n) (s : PlayState n) : PlayState n :=
  if s.won then s
  else
    let Q := σ s.hist
    if (Q.image s.arr).card = Q.card then
      { arr := s.arr ∘ W.perm s.hist Q
      , hist := s.hist ++ [(Q, reveal s.arr Q)]
      , won := false }
    else { s with won := true }

def play {n : ℕ} (σ : Strategy n) (W : Wizard n) : ℕ → PlayState n
  | 0 => { arr := W.init, hist := [], won := false }
  | m + 1 => step σ W (play σ W m)

def Winnable (n k : ℕ) : Prop :=
  ∃ m ≥ 1, ∃ σ : Strategy n, σ.Valid k ∧ ∀ W : Wizard n, W.Valid → (play σ W m).won

abbrev answer : ℕ → ℕ → Prop := fun n k ↦ k < n

theorem _root_.LeanGolf.compfiles.usa2016_p6 (n k : ℕ) (hk : 2 ≤ k) (hkn : k ≤ n) : Winnable n k ↔ answer n k := by sorry
