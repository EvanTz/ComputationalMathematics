###########################
# Improved Euler's Method
###########################

## Initialization
h = 0.1;
t = 0:h:600;

AM = (2631+3088+2977)/3
Dx = 11835 + AM;
Dy = 11835 + AM;
Dz = 6000;
m = 425000;
mz = 357000000;
ma = 113000;
x(1) = 0;
y(1) = -AM/1000;
z(1) = 0;

###############   [fx,fy,nz] = [-AM,0,0]   #############
nz = 0;
fy = 0;
fx = -AM;

x = zeros(size(t));
y = zeros(size(t));
z = zeros(size(t));

n = numel(z);

u = zeros(size(t));
u(1) = 0;
w = zeros(size(t));
w(1) = 0;
v = zeros(size(t));
v(1) = 0;

## may the force, be with you:
for i = 1:(n-1)
  #Z (\\psi)
  df  = (nz - (2 * Dz * abs(u(i)) * u(i))) / mz;
  #X
  dg = (((fx - Dx * abs(w(i)) * w(i))/(m+3*ma)) + sin(z(i))*u(i)*w(i) - cos(z(i))*u(i)*v(i))/cos(z(i));
  #Y
  dp = (((fy - Dy * abs(v(i)) * v(i))/(m+2*ma)) + cos(z(i))*u(i)*w(i) + sin(z(i))*u(i)*v(i))/cos(z(i));

  #every k1(z,x,y)
  k1z = df;
  k1x = dg;
  k1y = dp;

  #every k2(z,x,y)
  k2z = u(i) + (h * df);
  k2x = dg + h * dg;
  k2y = dp + h*dp;

  #every k1 (u,w,v)
  k1u = df;
  k1w = dg;
  k1v = dp;

  #every k2 (u,w,v)
  k2u = (nz - (2 * Dz * abs(k1z) * k1z)) / mz;
  k2w = (((fx - Dx * abs(k2x)*k2x)/m+3*ma) + sin(z(i)+h*u(i))*(u(i) + h*k1u)*k2x - cos(z(i) + h * u(i))*(u(i) + h * k1u) * (v(i) + h*dp))/cos(z(i) + h*k1u);
  k2v = (((fy -Dy*abs(k2y) * k2y)/m+2*ma + cos(z(i) + h*u(i)) * (u(i) + h*k1u) * (w(i) + h*k1w) + sin(z(i) + h*u(i))*(u(i)+h*k1u)*k2y))/cos(z(i) + h*k1u);

  #Z
  u(i+1) = u(i) + (h/2) * (k1u + k2u);
  z(i+1) = z(i) + (h/2) * (k1z + k2z);

  #X
  w(i+1)= w(i) + (h/2) * (k1w + k2w);
  x(i+1)= x(i) + (h/2) * (k1x + k2x);

  #Y
  v(i+1) = v(i) + (h/2) * (k1v + k2v);
  y(i+1) = y(i) + (h/2) * (k1y + k2y);
endfor

subplot(3,1,1);
plot(t,x);
title("x(t)");
grid on;

subplot(3,1,2);
plot(t,y);
title("y(t)");
grid on;

subplot(3,1,3);
plot(t,z);
title("\\psi(t)");
grid on;
