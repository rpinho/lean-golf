import Mathlib
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa1974P4

inductive Player | A | B | C
  deriving DecidableEq

def third : Player → Player → Player
  | .A, .B => .C
  | .B, .A => .C
  | .A, .C => .B
  | .C, .A => .B
  | .B, .C => .A
  | .C, .B => .A
  | _, _ => .A

def probWinA (win : Player → Player → ℝ) :
    ℕ → Player → Player → List Player → ℝ
  | 0, _, _, _ => 0
  | n + 1, w, i, hist =>
      win w i * (if w ∈ hist then (if w = .A then 1 else 0)
                 else probWinA win n w (third w i) (w :: hist)) +
      win i w * (if i ∈ hist then (if i = .A then 1 else 0)
                 else probWinA win n i (third w i) (i :: hist))

def probFirstAB (win : Player → Player → ℝ) : ℝ := probWinA win 4 .A .B []

def probFirstAC (win : Player → Player → ℝ) : ℝ := probWinA win 4 .A .C []

def probFirstBC (win : Player → Player → ℝ) : ℝ := probWinA win 4 .B .C []

theorem _root_.LeanGolf.compfiles.usa1974_p4
    (win : Player → Player → ℝ)
    (hwin : ∀ x y : Player, x ≠ y → 0 < win x y ∧ win x y + win y x = 1)
    -- "A is the weakest player, C the strongest"; the proof only uses that A is
    -- more likely to beat B than to beat C.
    (hweak : win Player.A Player.C < win Player.A Player.B) :
    probFirstBC win < probFirstAB win ∧ probFirstAC win < probFirstAB win := by sorry
