clear;
qrcirc_init;

[t y] = ode45(@qrcirc_odefun, [0,1000], [1 0 1]');

dq = [];
K = size(t,1);
for i=1:K
  dq(i,:) = (Q2(y(i,1:2)') * y(i,3))';
end

subplot(1, 2, 1);
plot(y(:,1),y(:,2));
grid on;
subplot(1, 2, 2);
plot(t, 0.5 .* (dq(:,1).^2 + dq(:,2).^2) - 0.5);
grid on;
