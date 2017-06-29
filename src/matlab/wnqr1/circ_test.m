clear all;
close all;

sys = sys_circ;

wav = struct();
wav.q = @(t)([1;0] + [0;t]);
wav.dq = @(t)([0;1]);
wav.ddq = @(t)([0;0]);
wav.lambda = @(t)(0);
wav.Q1 = [1;0];
wav.Q2 = [0;1];
wav.R = 1;

q0 = [1;0];
dq0 = [0;1];


rhs = @(t,x)wn_ode_rhs(t,x,sys,wav);

z0 = (wav.Q2)'*[0;0];
dz0 = (wav.Q2)'*[0;0];

t = [0:0.1:2*pi];
plot(cos(t),sin(t), '--');
xlim([-1.25,1.25])
daspect([1 1 1]);
grid on;
hold on;

q = [];
for t=0:0.1:1
  q(:,end+1) = wav.q(t);
end
plot(q(1,:), q(2,:));
daspect([1 1 1]);
hold on

%[tt,xx] = ode45(rhs, [0,1], [dz0;z0]);
sol = ode45(rhs, [0,1], [dz0;z0]);

wav2 = struct();
wav2.q = @(t)(wav.q(t) + wn_ode_q(t,deval(sol,t),sys,wav));
wav2.dq = @(t)(wav.dq(t) + wn_ode_dq(t,deval(sol,t),sys,wav));
wav2.ddq = @(t)(wav.ddq(t) + wn_ode_ddq(t,deval(sol,t),sys,wav));
wav2.lambda = wav.lambda;
wav2.Q1 = wav.Q1;
wav2.Q2 = wav.Q2;
wav2.R = wav.R;

q = [];
for t=0:0.1:1
  q(:,end+1) = wav2.q(t);
end
plot(q(1,:), q(2,:));
daspect([1 1 1]);
hold on

sol2 = ode45(rhs, [0,1], [dz0;z0]);

wav3 = struct();
wav3.q = @(t)(wav2.q(t) + wn_ode_q(t,deval(sol,t),sys,wav2));
wav3.dq = @(t)(wav2.dq(t) + wn_ode_dq(t,deval(sol,t),sys,wav2));
wav3.ddq = @(t)(wav2.ddq(t) + wn_ode_ddq(t,deval(sol,t),sys,wav2));

q = [];
for t=0:0.1:1
  q(:,end+1) = wav3.q(t);
end
plot(q(1,:), q(2,:));
daspect([1 1 1]);
hold on

%%wav3.lambda = wav2.lambda;
