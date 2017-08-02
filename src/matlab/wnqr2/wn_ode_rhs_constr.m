function varargout = wn_ode_rhs_constr(t, u, s, sys, wav)

if nargout >= 1
  q = wav.q(t);
  Phi = sys.Phi(t,q);
  varargout{1} = Phi;
end

if nargout >= 2
  Phi_q = sys.Phi_q(t,q);
  Q10 = sys.Q1(wav.q(0));
  S = Q10 * inv(Phi_q * Q10);
  varargout{2} = S;
end

if nargout >= 3
  Q20 = sys.Q2(wav.q(0));
  Q2 = (eye(2) - S * Phi_q) * Q20;
  varargout{3} = Q2;
end

if nargout >= 4
  dq = wav.dq(t);
  dPhi = sys.dPhi(t,q,dq);
  varargout{4} = dPhi;
end

if nargout >= 5
  dPhi_q = sys.dPhi_q(t,q,dq);
  varargout{5} = dPhi_q;
end

if nargout >= 6
  ddq = wav.ddq(t);
  ddPhi = sys.ddPhi(t,q,dq,ddq);
  varargout{6} = ddPhi;
end

if nargout >= 7
  ddPhi_q = sys.ddPhi_q(t, q, dq, ddq);
  varargout{7} = ddPhi_q;
end

if nargout >= 8
  dQ2 = sys.dQ2(q,dq);
  varargout{8} = dQ2;
end
