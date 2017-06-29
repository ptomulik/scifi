function ddq = wn_ode_ddq(t, y, sys, wav)

  [dz, z, Sw, Q2w, Phi, dPhi, ddPhi, Phi_q, dPhi_q, ddPhi_q] = wn_ode_rhs_helper(t, y, sys, wav);
  ddz = wn_ode_rhs_ddz(t, dz, z, Sw, Q2w, Phi, dPhi, ddPhi, dPhi_q, ddPhi_q, sys, wav);

  q = wn_post_q(t,y,sys,wav);
  dq = wn_post_dq(t,y,sys,wav);
  gamma = -ddPhi - 2.*dPhi_q*dq - ddPhi_q*q;
  ddq = Sw*gamma + Q2w*ddz;
