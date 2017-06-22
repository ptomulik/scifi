clear all;
qrcirc_init;

t = [0];
y = [1 0 -1];
dq = [0 1];
q_ = y(1,1:2)';

while(t(end) <= 1000)
  t0 = t(end)
  y0 = y(end,:)';
  % Projection...
  q0 = y0(1:2,1);
  dq0 = Q2u(q_,q0)*y0(3,1);
  q = qrcirc_proj2(q0);
  q_ = q;
  dz = Q2(q_)'*dq0;
  y0 = [q;dz];

  [tt yy] = ode45(@qrcirc_odefun3, [t0,1010], y0, odeset('OutputFcn',@qrcirc_outfun3));
  K = size(tt,1);
  for i=1:K
    qq = yy(i,1:2)';
    dz = yy(i,3)';
    dqq = (Q2u(q_,qq)*dz);
    dq(end+1,:) = dqq';
  end
  t = [t;tt];
  y = [y;yy];
end

subplot(1, 2, 1);
plot(y(:,1),y(:,2));
grid on;
subplot(1, 2, 2);
plot(t, 0.5 .* (dq(:,1).^2 + dq(:,2).^2) - 0.5);
grid on;
