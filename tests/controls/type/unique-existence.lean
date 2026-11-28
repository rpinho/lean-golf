import Mathlib.Logic.ExistsUnique
theorem LeanGolf.fixture : ∃! n : Nat, n = 0 := ⟨0, rfl, fun _ h => h⟩
