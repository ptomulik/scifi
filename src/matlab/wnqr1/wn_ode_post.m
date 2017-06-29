function [qh, dqh, ddqh] = wn_ode_post(tt, yy, sys, wav)

  qh = [];
  dqh = [];
  ddqh = [];
  for i = 1:size(tt)
    t = tt(i);
    y = yy(i,:)';

    [dz, z, Sw, Q2w, Phi, dPhi, ddPhi, Phi_q, dPhi_q, ddPhi_q] = wn_ode_rhs_helper(t, y, sys, wav);
    ddz = wn_ode_rhs_ddz(t, dz, z, Sw, Q2w, Phi, dPhi, ddPhi, dPhi_q, ddPhi_q, sys, wav);

    qh(:,end+1) = -Sw*Phi + Q2w*z;
    nuh = -dPhi - dPhi_q*qh(:,end);
    dqh(:,end+1) = Sw*nuh + Q2w*dz;
    gammah = -ddPhi - 2.*dPhi_q*dqh(:,end) - ddPhi_q*qh(:,end);
    ddqh(:,end+1) = Sw*gammah + Q2w*ddz;
  end
