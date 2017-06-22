function dy = qrcirc_odefun2(t,y)
  global Q1;
  global Q2;
  global Q2u;
  global Su;
  global GAMMA;
  global q_;
  z = y(1,:);
  dz = y(2,:);
  q = qrcirc_proj2(q_ + Q2(q_)*z);
  dq = Q2u(q_,q) * dz;
  ddz = - (Q2u(q_,q)'*Q2u(q_,q))\(Q2u(q_,q)'*Su(q_,q)*GAMMA(dq));
  dy = [dz; ddz];
