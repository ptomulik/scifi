function F1 = wn_F1(t, sys, wav)
  ddq = wav.ddq(t);
  dq = wav.dq(t);
  q = wav.q(t);
  l = wav.lambda(t);
  M = sys.M(t,q);
  Phi_q = sys.Phi_q(t,q);
  g = sys.g(t,dq,q);

  F1 = M * ddq + Phi_q' * l - g;
