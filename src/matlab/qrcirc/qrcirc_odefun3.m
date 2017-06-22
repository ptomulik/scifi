function dy = qrcirc_odefun2(t,y)
  global Q1;
  global Q2;
  global Q2u;
  global Su;
  global GAMMA;
  global q_;
  q0 = y(1:2,:);
  dz = y(3,:);
  q = qrcirc_proj2(q0);
  dq = Q2u(q_,q) * dz;
  ddz = - (Q2u(q_,q)'*Q2u(q_,q))\(Q2u(q_,q)'*Su(q_,q)*GAMMA(dq));
  dy = [dq; ddz];
