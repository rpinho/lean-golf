import Mathlib.Algebra.Order.Star.Basic
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Powerset

noncomputable section

namespace Usa2015P3

abbrev Coloring (n : ℕ) : Type := Finset (Fin n) → Bool

def blueCard {n : ℕ} (c : Coloring n) (T : Finset (Fin n)) : ℕ :=
  (T.powerset.filter fun W => c W = true).card

def IsValid {n : ℕ} (c : Coloring n) : Prop :=
  ∀ T₁ T₂ : Finset (Fin n),
    blueCard c T₁ * blueCard c T₂ = blueCard c (T₁ ∪ T₂) * blueCard c (T₁ ∩ T₂)

def ValidColorings (n : ℕ) : Type := {c : Coloring n // IsValid c}

instance (n : ℕ) : DecidablePred (@IsValid n) := fun _ => Fintype.decidableForallFintype

instance (n : ℕ) : Fintype (ValidColorings n) := Subtype.fintype _

def DisjointPairs (n : ℕ) : Type :=
  {p : Finset (Fin n) × Finset (Fin n) // Disjoint p.1 p.2}

instance (n : ℕ) : Fintype (DisjointPairs n) := Subtype.fintype _

abbrev NumberOfColorings (n : ℕ) : ℕ := 3 ^ n + 1

theorem _root_.LeanGolf.compfiles.usa2015_p3 (n : ℕ) :
    Fintype.card (ValidColorings n) = NumberOfColorings n := by sorry
