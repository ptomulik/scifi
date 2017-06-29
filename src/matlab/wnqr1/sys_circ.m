function sys = sys_circ

sys = struct();
sys.Phi = @(t,q)(q'*q - 1)./2;
sys.Phi_q = @(t,q)(q');
sys.M = @(t,q) eye(2);
sys.g = @(t,q,dq) [0, 0]';
sys.g_q = @(t,q,dq)(zeros(2));
sys.g_dq = @(t,q,dq)(zeros(2));
sys.dPhi = @(t,q,dq)(q'*dq);
sys.ddPhi = @(t,q,dq,ddq)(dq'*dq + q'*ddq);
sys.dPhi_q = @(t,q,dq)(dq');
sys.ddPhi_q = @(t,q,dq,ddq)(ddq');
sys.M_ddq_q = @(t,q,dq,ddq)(zeros(2));
sys.Phi_q_lambda_q = @(t,q,lambda)(lambda .* eye(2));
