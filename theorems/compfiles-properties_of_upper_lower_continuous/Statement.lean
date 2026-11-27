import Mathlib.Algebra.Ring.Equiv
import Mathlib
import Mathlib.Topology.Order
import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Topology.Algebra.Ring.Basic
import Mathlib.Topology.Bases
import Mathlib.Tactic.Linarith

noncomputable section

namespace UpperLowerContinuous

def upper_intervals : Set (Set ℝ) := {s : Set ℝ | ∃ a b : ℝ, Set.Ioc a b = s}

def lower_intervals : Set (Set ℝ) := {s : Set ℝ | ∃ a b : ℝ, Set.Ico a b = s}

def open_intervals : Set (Set ℝ) := {s : Set ℝ | ∃ a b : ℝ, Set.Ioo a b = s}

def tᵤ : TopologicalSpace ℝ := TopologicalSpace.generateFrom upper_intervals

def tₗ : TopologicalSpace ℝ := TopologicalSpace.generateFrom lower_intervals

def tₛ : TopologicalSpace ℝ := TopologicalSpace.generateFrom open_intervals

open Topology

theorem _root_.LeanGolf.compfiles.properties_of_upper_lower_continuous
    (f : ℝ → ℝ)
    (huc : Continuous[tᵤ, tᵤ] f)
    (hlc : Continuous[tₗ, tₗ] f)
    : Continuous[tₛ, tₛ] f ∧ Monotone f := by sorry
