import Mathlib.Tactic

noncomputable section

namespace Imo1996P1

abbrev OnBoard (p : ℤ × ℤ) : Prop := 1 ≤ p.1 ∧ p.1 ≤ 20 ∧ 1 ≤ p.2 ∧ p.2 ≤ 12

abbrev Move (r : ℤ) (p q : ℤ × ℤ) : Prop :=
  OnBoard p ∧ OnBoard q ∧ (p.1 - q.1) ^ 2 + (p.2 - q.2) ^ 2 = r

abbrev SqA : ℤ × ℤ := (1, 1)

abbrev SqB : ℤ × ℤ := (20, 1)

theorem _root_.LeanGolf.compfiles.imo1996_p1_a (r : ℤ) (hr : 2 ∣ r ∨ 3 ∣ r) :
    ¬ Relation.ReflTransGen (Move r) SqA SqB := by sorry
