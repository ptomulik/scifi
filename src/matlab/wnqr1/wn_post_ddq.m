function ddq = wn_post_ddq(t, x, sys, wav)

  [z, s] = wn_ode_unpack(x);
  [Phi, S, Q2, dPhi, dPhi_q, ddPhi, ddPhi_q, dQ2] = wn_ode_rhs_constr(t, z, s, sys, wav);

  q = wn_post_q(t, x, sys, wav);
  dq = wn_post_dq(t, x, sys, wav);
  gamma = - ddPhi - ddPhi_q * q - 2 .* dPhi_q * dq;
  a = wn_ode_rhs_dyn(t, q, dq, S, Q2, gamma, sys, wav);
  ddq = S*gamma + Q2*a;
