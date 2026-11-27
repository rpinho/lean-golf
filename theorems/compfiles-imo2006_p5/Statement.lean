import Mathlib.Algebra.Polynomial.Roots
import Mathlib.Dynamics.PeriodicPts.Defs

open Function Polynomial

namespace Imo2006P5

theorem _root_.LeanGolf.compfiles.imo2006_p5 {P : Polynomial ℤ} (hP : 1 < P.natDegree) {k : ℕ} (hk : 0 < k) :
    (P.comp^[k] X - X).roots.toFinset.card ≤ P.natDegree := by sorry
