function ddz = wn_ode_rhs_ddz(t, dz, z, Sw, Q2w, Phi, dPhi, ddPhi, dPhi_q, ddPhi_q, sys, wav)

  F1 = wn_F1(t, sys, wav);
  F1_q = wn_F1_q(t, sys, wav);
  F1_dq = wn_F1_dq(t, sys, wav);
  M = sys.M(t,wav.q(t));

  A = -F1_dq + 2 .* M * Sw*dPhi_q;
  B = -F1_q - A*Sw*dPhi_q + M*Sw*ddPhi_q;
  c = -F1 - B*Sw*Phi - A*Sw*dPhi + M*Sw*ddPhi;

  Aw = Q2w'*A*Q2w;
  Bw = Q2w'*B*Q2w;
  cw = Q2w'*c;
  Mw = Q2w'*M*Q2w;

  ddz = Mw \ (Aw*dz + Bw*z + cw);
