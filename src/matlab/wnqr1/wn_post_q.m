function q = wn_post_q(t, x, sys, wav)
  [z, s] = wn_ode_unpack(x);
  [Phi, S, Q2] = wn_ode_rhs_constr(t, z, s, sys, wav);
  q = -S*Phi + Q2*z;
