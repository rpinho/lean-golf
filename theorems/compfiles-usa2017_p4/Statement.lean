import Mathlib.Data.Finset.Max
import Mathlib.Data.Fintype.Card

noncomputable section

namespace Usa2017P4

section Geometry

variable {m : ℕ}

def cdist (a b : Fin m) : ℕ := (b.val + m - a.val) % m

def wrap (r b : Fin m) : ℕ := if b.val < r.val then 1 else 0

end Geometry

section Process

variable {m : ℕ} (c : Fin m → Bool)

def avail (used : Finset (Fin m)) : Finset (Fin m) :=
  Finset.univ.filter (fun b => c b = false ∧ b ∉ used)

noncomputable def nb (used : Finset (Fin m)) (r : Fin m) : Fin m :=
  if h : (avail c used).Nonempty then
    Classical.choose (Finset.exists_min_image (avail c used) (cdist r) h)
  else r

noncomputable def wraps : List (Fin m) → Finset (Fin m) → ℕ
  | [], _ => 0
  | (r :: rs), used => wrap r (nb c used r) + wraps rs (insert (nb c used r) used)

end Process

theorem _root_.LeanGolf.compfiles.usa2017_p4 (n : ℕ) (_hn : 0 < n) (c : Fin (2 * n) → Bool)
    (hred : (Finset.univ.filter (fun i => c i = true)).card = n)
    (l₁ l₂ : List (Fin (2 * n)))
    (hnod₁ : l₁.Nodup) (hlen₁ : l₁.length = n) (hred₁ : ∀ r ∈ l₁, c r = true)
    (hnod₂ : l₂.Nodup) (hlen₂ : l₂.length = n) (hred₂ : ∀ r ∈ l₂, c r = true) :
    wraps c l₁ ∅ = wraps c l₂ ∅ := by sorry
