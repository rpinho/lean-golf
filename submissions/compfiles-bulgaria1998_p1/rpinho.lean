import Mathlib.Tactic

theorem _root_.LeanGolf.compfiles.bulgaria1998_p1 : IsLeast { m | all_colorings_are_good m } solution_value := ⟨by decide +kernel, fun m h => by by_contra! H; interval_cases m <;> revert h <;> decide +kernel⟩
