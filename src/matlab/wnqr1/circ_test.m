clear all;
close all;

sys = circ_sys;

tspan = [0, 2.*pi];

wav{1} = struct();
wav{1}.q = @(t)([1;0] + [0;t]);
wav{1}.dq = @(t)([0;1]);
wav{1}.ddq = @(t)([0;0]);
wav{1}.lambda = @(t)(1);
%%om = 6/5;
%%wav{1}.q = @(t)([(1-1/om) + 1/om*cos(om*t); 1/om*sin(om*t)]);
%%wav{1}.dq = @(t)([-sin(om*t); cos(om*t)]);
%%wav{1}.ddq = @(t)([-om*cos(om*t); -om*sin(om*t)]);

z0 = 0;
s0 = 0;

t = [0:0.1:2*pi];
%t = [tspan(1):0.05:tspan(end)];
%plot(cos(t),sin(t), '--');
figure('units','normalized','outerposition',[0 0 1 1])
plot(cos(t),sin(t), '--');
%t = [tspan(1):0.05:tspan(end)]
%plot(t, cos(t), '--');
xlim([-1.25,1.25])
ylim([-1.25,1.25])
daspect([1 1 1]);
grid on;
hold on;

plot(cos(tspan(end)), sin(tspan(end)), '*')
hold on;
drawnow;

q = [];
for t = [tspan(1):0.01:tspan(end)]
  q(:,end+1) = wav{1}.q(t);
%%  q(:,end+1) = wav{1}.dq(t);
%%  q(:,end+1) = wav{1}.ddq(t);
%%  q(:,end+1) = wav{1}.lambda(t);
end
plot(q(1,:), q(2,:), '-*');
%plot([tspan(1):0.01:tspan(end)], q(1,:), '-*');
daspect([1 1 1]);
hold on
drawnow

maxiter = 10;
for i=1:maxiter

  rhs{i} = @(t,x)wn_ode_rhs(t,x,sys, wav{i});
  sol{i} = ode45(rhs{i}, tspan, [s0;z0], odeset('RelTol',1e-7, 'AbsTol', 1e-7));

  wav{i+1} = struct();
  wav{i+1}.f_q = @(t)(wav{i}.q(t) + wn_post_q(t,deval(sol{i},t),sys,wav{i}));
  wav{i+1}.f_dq = @(t)(wav{i}.dq(t) + wn_post_dq(t,deval(sol{i},t),sys,wav{i}));
  wav{i+1}.f_ddq = @(t)(wav{i}.ddq(t) + wn_post_ddq(t,deval(sol{i},t),sys,wav{i}));
  wav{i+1}.f_lambda = @(t)(wav{i}.lambda(t) + wn_post_lambda(t,deval(sol{i},t),sys,wav{i}));

  wav{i+1}.d_q = [];
  wav{i+1}.d_dq = [];
  wav{i+1}.d_ddq = [];
  wav{i+1}.d_lambda = [];
  %for t = sol{i}.x
  %%pp_t =  [tspan(1):0.01:tspan(end)]
  pp_t = sol{i}.x;
  for t = pp_t
    wav{i+1}.d_q(:,end+1) = wav{i+1}.f_q(t);
    wav{i+1}.d_dq(:,end+1) = wav{i+1}.f_dq(t);
    wav{i+1}.d_ddq(:,end+1) = wav{i+1}.f_ddq(t);
    wav{i+1}.d_lambda(:,end+1) = wav{i+1}.f_lambda(t);
  end

  wav{i+1}.pp_q = spapi(4, [pp_t(1), pp_t(1), pp_t], [wav{i+1}.d_q(:,1), wav{i+1}.d_dq(:,1), wav{i+1}.d_ddq(:,1), wav{i+1}.d_q(:,2:end)]);
  wav{i+1}.pp_dq = spapi(3, [pp_t(1), pp_t], [wav{i+1}.d_dq(:,1), wav{i+1}.d_ddq(:,1), wav{i+1}.d_dq(:,2:end)]);
  wav{i+1}.pp_ddq = spapi(3, [pp_t(1), pp_t], [wav{i+1}.d_ddq(:,1), [0,-1]', wav{i+1}.d_ddq(:,2:end)]);
  wav{i+1}.pp_lambda = spapi(3, [pp_t(1), pp_t], [wav{i+1}.d_lambda(:,1), 0, wav{i+1}.d_lambda(:,2:end) ]);

  wav{i+1}.q = @(t)(fnval(wav{i+1}.pp_q, t));
  wav{i+1}.dq = @(t)(fnval(wav{i+1}.pp_dq, t));
  wav{i+1}.ddq = @(t)(fnval(wav{i+1}.pp_ddq, t));
  wav{i+1}.lambda = @(t)(fnval(wav{i+1}.pp_lambda, t));

%%  wav{i+1}.q = @(t)(wav{i}.q(t) + wn_post_q(t,deval(sol{i},t),sys,wav{i}));
%%  wav{i+1}.dq = @(t)(wav{i}.dq(t) + wn_post_dq(t,deval(sol{i},t),sys,wav{i}));
%%  wav{i+1}.ddq = @(t)(wav{i}.ddq(t) + wn_post_ddq(t,deval(sol{i},t),sys,wav{i}));
%%  wav{i+1}.lambda = @(t)(wav{i}.lambda(t) + wn_post_lambda(t,deval(sol{i},t),sys,wav{i}));

  q = [];
  for t = sol{i}.x
    q(:,end+1) = wav{i+1}.q(t);
%%    q(:,end+1) = wav{i+1}.dq(t);
%%    q(:,end+1) = wav{i+1}.ddq(t);
%%    q(:,end+1) = wav{i+1}.lambda(t);
  end
  plt(i) = plot(q(1,:), q(2,:), '-*');
  %plt(i) = plot(sol{i}.x, q(1,:), '-*');
  leg(i) = sprintf("%d", i);
  daspect([1 1 1]);
  hold on
  drawnow
end
legend(plt,leg)
