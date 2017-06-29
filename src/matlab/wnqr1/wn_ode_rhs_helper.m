function [dz, z, Sw, Q2w, Phi, dPhi, ddPhi, Phi_q, dPhi_q, ddPhi_q] = wn_ode_rhs_helper(t, y, sys, wav)

  n = size(y,1)/2;
  dz = y(1:n,1);
  z = y(n+1:end,1);

  q = wav.q(t);
  dq = wav.dq(t);
  ddq = wav.ddq(t);

  Q1 = wav.Q1;
  Q2 = wav.Q2;
  R = wav.R;

  Phi = sys.Phi(t,q);
  dPhi = sys.dPhi(t,q,dq);
  ddPhi = sys.ddPhi(t,q,dq,ddq);
  Phi_q = sys.Phi_q(t,q);
  dPhi_q = sys.dPhi_q(t,q,dq);
  ddPhi_q = sys.ddPhi_q(t, q, dq, ddq);

  Sw = Q1 * inv(Phi_q*Q1);
  Q2w = (eye(n) - Sw*Phi_q) * Q2;
