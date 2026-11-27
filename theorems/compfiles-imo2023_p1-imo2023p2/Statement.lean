import Mathlib

open Affine Affine.Simplex EuclideanGeometry FiniteDimensional Module

open scoped Affine EuclideanGeometry Real InnerProductSpace

attribute [local instance] FiniteDimensional.of_fact_finrank_eq_two

variable (V : Type*) (Pt : Type*)

variable [NormedAddCommGroup V] [InnerProductSpace ℝ V] [MetricSpace Pt]

variable [NormedAddTorsor V Pt] [hd2 : Fact (finrank ℝ V = 2)]

variable [Module.Oriented ℝ V (Fin 2)]

namespace Imo2023P2

theorem _root_.LeanGolf.compfiles.imo2023_p1_imo2023p2
  -- Points
  (A B C D E L S P : Pt)
  -- Circles
  (Ω ω : Sphere Pt)
  -- Lines
  (perp_A_BC prll_D_BC tang_P_ω : AffineSubspace ℝ Pt)
  -- Let ABC be an acute-angled triangle
  (h_ABC : AffineIndependent ℝ ![A, B, C])
  (h_acute_ABC : (⟨![A, B, C], h_ABC⟩ :Affine.Triangle _ _).AcuteAngled)
  -- with AB < AC.
  (h_AB_lt_BC : dist A B < dist A C)
  -- Let Ω be the circumcircle of ABC.
  (h_Ω : {A, B, C} ⊆ (Ω : Set Pt))
  -- Let S be the midpoint of the arc CB of Ω
  (h_S_Ω : dist S C = dist S B ∧ S ∈ (Ω : Set Pt))
  -- ... containing A.
  (h_S_A : (∡ C B S).sign = (∡ C B A).sign)
  -- The perpendicular from A to BC ...
  (h_perp_A_BC : perp_A_BC.direction ⟂ line[ℝ, B, C].direction ∧ A ∈ perp_A_BC)
  -- ... meets BS at D
  (h_D : D ∈ (perp_A_BC : Set Pt) ∩ line[ℝ, B, S])
  -- ... and meets Ω again at E ...
  (h_E : E ∈ (perp_A_BC : Set Pt) ∩ Ω)
  -- ... E ≠ A.
  (h_E_ne_A : E ≠ A)
  -- The line through D parallel to BC ...
  (h_prll_D_BC : D ∈ prll_D_BC ∧ prll_D_BC ∥ line[ℝ, B, C])
  --- ... meets line BE at L.
  (h_L : L ∈ (prll_D_BC : Set Pt) ∩ line[ℝ, B, E])
  -- Denote the circumcircle of triangle BDL by ω.
  (h_ω : {B, D, L} ⊆ (ω : Set Pt))
  -- Let ω meet Ω again at P ...
  (h_P : P ∈ (ω : Set Pt) ∩ Ω)
  -- P ≠ B.
  (h_P_ne_B : P ≠ B)
  -- Prove that the line tangent to ω at P ...
  (h_rank_tang_P_ω : Module.finrank ℝ tang_P_ω.direction = 1)
  (h_tang_P_ω : Sphere.IsTangentAt ω P tang_P_ω) :
  -- meets line BS on the internal angle bisector of ∠BAC.
  ∃ X : Pt,
    X ∈ (tang_P_ω : Set Pt) ∩ line[ℝ, B, S]
    ∧ ∠ B A X = ∠ X A C
    ∧ ∠ B A X < π / 2 := by sorry
