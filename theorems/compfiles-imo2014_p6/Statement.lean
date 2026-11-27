import Mathlib.Algebra.EuclideanDomain.Basic
import Mathlib.Algebra.EuclideanDomain.Field
import Mathlib.Algebra.Order.Star.Real
import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Analysis.Normed.Order.Lattice
import Mathlib.Order.CompletePartialOrder

noncomputable section

namespace Imo2014P6

structure Line where
  a : ℝ
  b : ℝ
  c : ℝ
  hab : a ≠ 0 ∨ b ≠ 0

noncomputable instance : DecidableEq Line := Classical.decEq _

namespace Line

def val (ℓ : Line) (p : ℝ × ℝ) : ℝ := ℓ.a * p.1 + ℓ.b * p.2 + ℓ.c

def set (ℓ : Line) : Set (ℝ × ℝ) := {p | ℓ.val p = 0}

def det (ℓ m : Line) : ℝ := ℓ.a * m.b - m.a * ℓ.b

noncomputable def interPt (ℓ m : Line) : ℝ × ℝ :=
  ((ℓ.b * m.c - m.b * ℓ.c) / ℓ.det m, (m.a * ℓ.c - ℓ.a * m.c) / ℓ.det m)

end Line

def GeneralPosition (L : Finset Line) : Prop :=
  (∀ ℓ ∈ L, ∀ m ∈ L, ℓ ≠ m → ℓ.det m ≠ 0) ∧
  (∀ ℓ ∈ L, ∀ m ∈ L, ∀ n ∈ L, ℓ ≠ m → ℓ ≠ n → m ≠ n → n.val (ℓ.interPt m) ≠ 0)

def sgn (b : Bool) : ℝ := if b then 1 else -1

def Cell (L : Finset Line) (σ : Line → Bool) : Set (ℝ × ℝ) :=
  {p | ∀ ℓ ∈ L, sgn (σ ℓ) * ℓ.val p > 0}

theorem _root_.LeanGolf.compfiles.imo2014_p6 :
    ∃ N : ℕ, ∀ n ≥ N, ∀ L : Finset Line, L.card = n → GeneralPosition L →
      ∃ B : Finset Line, B ⊆ L ∧ Real.sqrt n ≤ B.card ∧
        ∀ σ : Line → Bool, (Cell L σ).Nonempty → Bornology.IsBounded (Cell L σ) →
          ¬ (frontier (Cell L σ) ⊆ ⋃ ℓ ∈ B, ℓ.set) := by sorry
