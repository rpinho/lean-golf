import Mathlib.Analysis.Polynomial.Basic
import Mathlib.LinearAlgebra.Lagrange
import Mathlib.Topology.Algebra.Polynomial

namespace Usa2002P3

open Polynomial Filter Asymptotics

theorem _root_.LeanGolf.compfiles.usa2002_p3 (n : ℕ) (p : ℝ[X]) (hpm : p.Monic) (hpn : p.natDegree = n) :
    ∃ q r : ℝ[X], q.Monic ∧ r.Monic ∧ q.natDegree = n ∧ r.natDegree = n ∧
      q.roots.card = n ∧ r.roots.card = n ∧
      q.Splits ∧ r.Splits ∧ p = (q + r) / 2 := by sorry
