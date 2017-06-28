function sys = sys_circ

sys = struct();
sys.Phi = @(t,q)(q'*q - 1);
sys.Phi_q = @(t,q)(2 .* q');
sys.M = @(t,q) eye(2);
sys.g = @(t,q,dq) [0, 0]';
sys.g_q = @(t,q,dq)(zeros(2));
sys.dPhi = @(t,q,dq)(2 .* q'*dq);
sys.ddPhi = @(t,q,dq,ddq)(2 .* (dq'*dq + q'*ddq));
sys.dPhi_q = @(t,q,dq)(2 .* dq');
sys.ddPhi_q = @(t,q,dq,ddq)(2 .* ddq');
sys.M_ddq_q = @(t,q,dq,ddq)(zeros(2));
sys.Phi_q_lambda_q = @(t,q,lambda)(2 .* lamda .* eye(2));
sys.nu = @(t,q,dq)([0 0]');
sys.gamma = @(t,q,dq)(-2 .* dq'*dq);
