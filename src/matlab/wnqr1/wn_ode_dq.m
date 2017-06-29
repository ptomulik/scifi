function dq = wn_ode_dq(t, y, sys, wav)

  [dz, z, Sw, Q2w, Phi, dPhi, ddPhi, Phi_q, dPhi_q, ddPhi_q] = wn_ode_rhs_helper(t, y, sys, wav);
  q = wn_ode_q(t,y,sys,wav);
  nuh = -dPhi - dPhi_q*q;
  dq = Sw*nuh + Q2w*dz;
