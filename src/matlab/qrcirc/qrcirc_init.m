global PHI;
global PHI_q;
global GAMMA;
global Q1;
global Q2;
global q_;
global Q1u;
global Q2u;
global R1u;
global Su;

if(exist('OCTAVE_VERSION', 'builtin') > 0)
    pkg load odepkg
end

% For all methods
PHI = @(q) q(1).^2 + q(2).^2 - 1;
PHI_q = @(q) 2.*[q(1), q(2)];
GAMMA = @(dq) (-2 * (dq'*dq));
Q1 = @(q) 1/sqrt(q(1).^2 + q(2).^2) * [q(1); q(2)];
Q2 = @(q) 1/sqrt(q(1).^2 + q(2).^2) * [q(2);-q(1)];

% For the methods with update
Q1u = @(q_,q) Q1(q_);
Su = @(q_,q) Q1(q_) * inv(PHI_q(q)*Q1(q_));
Q2u = @(q_,q) Q2(q_) - Su(q_,q)*PHI_q(q)*Q2(q_);
