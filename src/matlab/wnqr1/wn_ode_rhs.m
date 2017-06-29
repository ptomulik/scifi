function dy = ode_rhs(t, y, sys, wav)

  [dz, z, Sw, Q2w, Phi, dPhi, ddPhi, Phi_q, dPhi_q, ddPhi_q] = wn_ode_rhs_helper(t, y, sys, wav);
  ddz = wn_ode_rhs_ddz(t, dz, z, Sw, Q2w, Phi, dPhi, ddPhi, dPhi_q, ddPhi_q, sys, wav);
  dy = [ddz;dz];
