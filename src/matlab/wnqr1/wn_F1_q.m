function F1_q = wn_F1_q(t, sys, vaw)
  ddq = wav.ddq(t);
  dq = wav.dq(t);
  q = wav.q(t);
  l = wav.lambda(t);

  M_ddq_q = sys.M_ddq_q(t,q,dq,ddq);
  Phi_q_lambda_q = sys.Phi_q_lambda_q(t,q,lambda);
  g_q = sys.g_q(t, dq, q);

  F1_q = M_ddq_q + Phi_q_lambda_dq - g_q;
