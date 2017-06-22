function q = qrcirc_proj(q0)
% QRCIRC_PROJ - position projection for the qrcirc example
%
% SYNOPSIS
%
%     q = qrcirc_proj(q0)
%
% ARGUMENTS
%
%     q0    initial position, which may be apart of circle line (constraints
%           surface)
%
% RETURN
%
%     q     corrected potision after the projection
%
%
% DESCRIPTION
%
% The function iterativelly solves the system of nonlinear equations
%
%     PHI(q)       = 0
%     Q2(q)*(q-q0) = 0
%
% Where PHI(q) = 0 is the circle equation and Q2 is the null-space basis for
% the Jacobian PHI_q. The above system represents orthogonal projection from
% point q0 near to the circle line to a point q on the circle line. The
% projection is performed such that the correction (q - q0) is orthogonal to
% the circle line at point q.
%
% NOTE
%
% Before using this function for the first time, you must invoke qrcirc_init.
%
  global PHI;
  global PHI_q;
  global Q1;
  global Q2;
  JII = @(q) [q0(2), -q0(1)]./norm(q) * (eye(2) + Q1(q)*Q1(q)');
  J = @(q) [PHI_q(q);JII(q)];
  P = @(q)[PHI(q); Q2(q)'*(q-q0)];
  q = q0;
  for i=1:50
    delq = - J(q) \ P(q);
    if(norm(delq) < 1e-9)
      break;
    end
    q = q+delq;
  end
