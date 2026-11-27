import Mathlib.Data.Nat.Factorization.Basic

namespace Usa1972P1

open Nat

theorem _root_.LeanGolf.compfiles.usa1972_p1 (a b c : ℕ) :
  (gcd a (gcd b c)) ^ 2 * lcm a b * lcm b c * lcm c a =
  (lcm a (lcm b c)) ^ 2 * gcd a b * gcd b c * gcd c a := by sorry
