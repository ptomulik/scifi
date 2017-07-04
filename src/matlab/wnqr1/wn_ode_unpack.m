function [z, s] = wn_ode_unpack(x)
  n = size(x,1)/2;

  s = x(1:n,1);
  z = x(n+1:end,1);
