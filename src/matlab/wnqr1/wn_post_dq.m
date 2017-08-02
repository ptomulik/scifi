function dq = wn_post_dq(t, x, sys, wav)

  [u, s] = wn_ode_unpack(x);
  [Phi, S, Q2, dPhi, dPhi_q] = wn_ode_rhs_constr(t, u, s, sys, wav);
  q = wn_post_q(t,x,sys,wav);
  nu = -dPhi - dPhi_q*q;
  dq = S*nu + Q2*s;
