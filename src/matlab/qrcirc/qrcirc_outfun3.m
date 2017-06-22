function status = qrcirc_outfun3(t,y,flag)
global q_;
global Q2;
global Q2u;
global Su;
switch(flag)
  case []
    status = 0;
    K = size(y,2);
    for i=1:K
      q0 = y(1:2,i);
      dz = y(3,i);
      q = qrcirc_proj2(q0);
      dq = Q2u(q_,q)*dz;
      if((dz'*dz) < 0.5 * (dq'*dq))
        status = 1;
      end
    end
  otherwise
    status = 0;
end
