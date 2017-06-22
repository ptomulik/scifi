clear all;
qrcirc_init;

t = [0];
y = [1 0 1];

while(t(end) <= 1000)
  t0 = t(end)
  y0 = y(end,:)';
  % Projection...
  q0 = y0(1:2,1);
  s = y0(3,1);
  q = qrcirc_proj(q0);
  y0 = [q;s];

  [tt yy] = ode45(@qrcirc_odefun, [t0,1010], y0, odeset('OutputFcn',@qrcirc_outfun));
  t = [t;tt];
  y = [y;yy];
end

dq = [];
q = [];
for i=1:size(t,1)
  q(i,:) = y(i,1:2);
  dq(i,:) = (Q2(q(i,:)')*y(i,3))';
end

subplot(1, 2, 1);
plot(q(:,1),q(:,2));
grid on;
subplot(1, 2, 2);
plot(t, 0.5 .* (dq(:,1).^2 + dq(:,2).^2) - 0.5);
grid on;
