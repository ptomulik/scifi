function varargout = wn_ode_rhs_constr(t, u, s, sys, wav)

if nargout >= 1
  q = wav.q(t);
  Phi = sys.Phi(t,q);
  varargout{1} = Phi;
end

if nargout >= 2
  Q1 = sys.Q1(q);
  R1 = sys.R1(q);
  S = Q1 * inv(R1);
  varargout{2} = S;
end

if nargout >= 3
  Q2 = sys.Q2(q);
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
