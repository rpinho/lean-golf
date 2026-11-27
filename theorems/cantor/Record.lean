import Mathlib.Logic.Function.Basic

theorem LeanGolf.cantor {α : Type u} (f : α → Set α) : ¬ Function.Surjective f := by
  intro h
  obtain ⟨a, ha⟩ := h {x | x ∉ f x}
  have e : a ∈ f a ↔ a ∉ f a := by
    calc
      a ∈ f a ↔ a ∈ {x | x ∉ f x} := by rw [ha]
      _ ↔ _ := Iff.rfl
  exact (fun hn => hn (e.mpr hn)) (fun hy => e.mp hy hy)
