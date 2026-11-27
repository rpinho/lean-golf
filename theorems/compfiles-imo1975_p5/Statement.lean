import Mathlib

noncomputable section

namespace Imo1975P5

abbrev constructible : Bool := true

theorem _root_.LeanGolf.compfiles.imo1975_p5 : constructible ↔
    ∃ p : Finset Circle, p.card = 1975 ∧ (SetLike.coe p).Pairwise (fun a b => ¬ Irrational (dist a b)) := by sorry
