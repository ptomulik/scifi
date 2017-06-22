clear all;
qrcirc_init;

t = [0];
y = [0 -1];
q = [1 0];
dq = [0 1];

while(t(end) <= 1000)
  t0 = t(end)
  q0 = q(end,:)';
  dq0 = dq(end,:)';
  q_ = q0;
%  z0 = 0;
  z0 = Q2(q_)'*(q0-q_);
  dz0 = Q2(q_)'*dq0
  y0 = [z0;dz0];
%%  [tt yy] = ode45(@qrcirc_odefun2, [t0,1001], y0, odeset('OutputFcn',@qrcirc_outfun2,'RelTol',1e-9,'AbsTol',1e-9));
%%  [tt yy] = ode45(@qrcirc_odefun2, [t0,1001], y0, odeset('OutputFcn',@qrcirc_outfun2));
  [tt yy] = ode113(@qrcirc_odefun2, [t0,1000+0.01], y0, odeset('OutputFcn',@qrcirc_outfun2,'RelTol',1e-6,'AbsTol',1e-6));
  K = size(tt,1);
  for i=1:K
    z = yy(i,1)';
    dz = yy(i,2)';
    qq = qrcirc_proj2(q_ + Q2(q_)*z);
    dqq = (Q2u(q_,qq)*dz);
    q(end+1,:) = qq';
    dq(end+1,:) = dqq';
  end
  t = [t;tt];
  y = [y;yy];
end

subplot(1, 2, 1);
plot(q(:,1),q(:,2));
grid on;
subplot(1, 2, 2);
plot(t, 0.5 .* (dq(:,1).^2 + dq(:,2).^2) - 0.5);
grid on;
