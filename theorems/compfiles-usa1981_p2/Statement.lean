import Mathlib.Tactic

noncomputable section

namespace Usa1981P2

inductive Link | air | bus | train
  deriving DecidableEq

instance : Fintype Link where
  elems := ⟨↑[Link.air, Link.bus, Link.train], by decide⟩
  complete := fun x => by cases x <;> decide

abbrev colorsAt {n : ℕ} (f : Fin n → Fin n → Link) (v : Fin n) : Finset Link :=
  (Finset.univ.filter (· ≠ v)).image (f v ·)

abbrev Valid {n : ℕ} (f : Fin n → Fin n → Link) : Prop :=
  (∀ i j, f i j = f j i) ∧
  (∃ i j, i ≠ j ∧ f i j = .air) ∧
  (∃ i j, i ≠ j ∧ f i j = .bus) ∧
  (∃ i j, i ≠ j ∧ f i j = .train) ∧
  (∀ v, (colorsAt f v).card ≤ 2) ∧
  (∀ a b c, a ≠ b → b ≠ c → a ≠ c → ¬ (f a b = f a c ∧ f a b = f b c))

abbrev answer : ℕ := 4

theorem _root_.LeanGolf.compfiles.usa1981_p2 :
    IsGreatest {n : ℕ | ∃ f : Fin n → Fin n → Link, Valid f} answer := by sorry
