function q = wn_post_q(t, x, sys, wav)
  [u, s] = wn_ode_unpack(x);
  [Phi, S, Q2] = wn_ode_rhs_constr(t, u, s, sys, wav);
  q = -S*Phi + Q2*u;
