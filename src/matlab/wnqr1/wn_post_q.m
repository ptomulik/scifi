function q = wn_ode_q(t, y, sys, wav)

  [dz, z, Sw, Q2w, Phi, dPhi, ddPhi, Phi_q, dPhi_q, ddPhi_q] = wn_ode_rhs_helper(t, y, sys, wav);
  q = -Sw*Phi + Q2w*z;
