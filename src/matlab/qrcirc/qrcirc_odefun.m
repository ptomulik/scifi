function dy = qrcirc_odefun(t,y)
  global Q2;
  q0 = y(1:2,:);
  s = y(3);
  q = qrcirc_proj(q0);
  dy = [Q2(q)*s; 0];
