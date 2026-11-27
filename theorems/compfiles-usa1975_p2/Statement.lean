import Mathlib

namespace Usa1975P2

theorem _root_.LeanGolf.compfiles.usa1975_p2
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (A B C D : E) :
    ‖A - C‖ ^ 2 + ‖B - D‖ ^ 2 + ‖A - D‖ ^ 2 + ‖B - C‖ ^ 2
      ≥ ‖A - B‖ ^ 2 + ‖C - D‖ ^ 2 := by sorry
