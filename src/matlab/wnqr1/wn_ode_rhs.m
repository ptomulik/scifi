function dx = wn_ode_rhs(t, x, sys, wav)

  [z, s] = wn_ode_unpack(x);
  [Phi, S, Q2, dPhi, dPhi_q, ddPhi, ddPhi_q, dQ2] = wn_ode_rhs_constr(t, z, s, sys, wav);

  q = - S * Phi + Q2 * z;
  nu = - dPhi - dPhi_q * q;
  dq = S * nu + Q2 * s;
  gamma = - ddPhi - ddPhi_q * q - 2 .* dPhi_q * dq;

  a = wn_ode_rhs_dyn(t, q, dq, S, Q2, gamma, sys, wav);

  dz = s + dQ2' * q;
  ds = a + dQ2' * dq;

  dx = wn_ode_pack(dz, ds);
