import Mathlib.Tactic

noncomputable section

namespace Usa2011P4

abbrev P (n : ℕ) : Prop := ∃ k, 4^k = 2^(2^n) % (2^n - 1)

inductive SolutionData where
| AlwaysTrue : SolutionData
| Counterexample : ℕ → SolutionData

abbrev solution_data : SolutionData := SolutionData.Counterexample 25

theorem _root_.LeanGolf.compfiles.usa2011_p4 :
    match solution_data with
    | .AlwaysTrue => ∀ n, 2 ≤ n → P n
    | .Counterexample m => 2 ≤ m ∧ ¬ P m := by sorry
