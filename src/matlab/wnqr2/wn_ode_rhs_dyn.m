function varargout = wn_ode_rhs_dyn(t, q, dq, S, Q2, gamma, sys, wav)

  F1 = wn_F1(t, sys, wav);
  F1_q = wn_F1_q(t, sys, wav);
  F1_dq = wn_F1_dq(t, sys, wav);
  M = sys.M(t, wav.q(t));

  MM = Q2' * M * Q2;

if nargout >= 1
  a = MM \ (Q2' * (-F1 - F1_dq * dq - F1_q * q - M * S * gamma));
  varargout{1} = a;
end
if nargout >= 2
  varargout{2} = M;
end
if nargout >= 3
  varargout{3} = F1;
end
if nargout >= 4
  varargout{4} = F1_q;
end
if nargout >= 5
  varargout{5} = F1_dq;
end
