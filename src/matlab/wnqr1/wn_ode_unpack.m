function [u, s] = wn_ode_unpack(x)
  n = size(x,1)/2;

  s = x(1:n,1);
  u = x(n+1:end,1);
