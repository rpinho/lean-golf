import Mathlib.Data.Multiset.Sort
import Mathlib.Data.Sym.Card
import Mathlib.SetTheory.Cardinal.Finite

noncomputable section

namespace Usa2015P4

abbrev solution : ℕ → ℕ → ℕ := fun m n ↦ (Nat.choose (m + n - 1) (n - 1)) ^ 2

abbrev Piling (n : ℕ) := Multiset (Fin n × Fin n)

def StoneMove {n : ℕ} (S T : Piling n) : Prop :=
  ∃ x₁ x₂ y₁ y₂ : Fin n, ∃ U : Piling n,
    x₁ ≠ x₂ ∧ y₁ ≠ y₂ ∧
    S = (x₁, y₁) ::ₘ (x₂, y₂) ::ₘ U ∧
    T = (x₁, y₂) ::ₘ (x₂, y₁) ::ₘ U

inductive EquivPilings {n : ℕ} : Piling n → Piling n → Prop where
  | refl (S : Piling n) : EquivPilings S S
  | move {S T : Piling n} : StoneMove S T → EquivPilings S T
  | symm {S T : Piling n} : EquivPilings S T → EquivPilings T S
  | trans {S T U : Piling n} : EquivPilings S T → EquivPilings T U → EquivPilings S U

instance pilingSetoid (m n : ℕ) : Setoid {S : Piling n // S.card = m} where
  r S T := EquivPilings S.1 T.1
  iseqv := {
    refl := fun S ↦ EquivPilings.refl S.1
    symm := fun h ↦ EquivPilings.symm h
    trans := fun h₁ h₂ ↦ EquivPilings.trans h₁ h₂
  }

theorem _root_.LeanGolf.compfiles.usa2015_p4 (m n : ℕ) (hm : 1 ≤ m) (hn : 1 ≤ n) :
    Nat.card (Quotient (pilingSetoid m n)) = solution m n := by sorry
