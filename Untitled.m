% firstly i define the values which on the example
f= 60;                     %the frequency value
p= 4;                      % the quantity of poles
r1 = 0.243;                 % stator resistance
x1 = 0.670;                 % stator reactance
r2 = 0.151;                 % rotor resistance
x2 = 0.670;                 % rotor reactance
xm = 14.03;                  % magnetizating reactance
v_phase = 120 ;             % phase voltage
n_sync = (120*f)/p;            % synchronous speed (r/min) 
w_sync = (4 * 3.14*f)/p;       % synchronous speed (rad/s)

% thevenin voltage calculations
v_th = v_phase * ( xm / sqrt(r1^2 + (x1 + xm)^2) );
z_th = ((j*xm) * (r1 + j*x1)) / (r1 + j*(x1 + xm));
r_th = real(z_th);
x_th = imag(z_th);

% calculation for torque-speed characteristic from 0 to 50 slip
s = (0:1:50) / 50;           % Slip
s(1) = 0.001;     % slip can not start with 0 thats why i started at 0.001
nm = (1 - s) * n_sync;       % Mechanical speed

% calculate torque for rotor resistance
for i = 1:51
   t_ind1(i) = (3 * v_th^2 * r2 / s(i)) / ...
            (w_sync * ((r_th + r2/s(i))^2 + (x_th + x2)^2) );
end

% torque-speed curve graph
plot(nm,t_ind1,'Color','k','LineWidth',2.0);
xlabel('\itn_{m}','Fontweight','Bold');
ylabel('\tau_{ind}','Fontweight','Bold');
title ('the torque-speed characteristic of an induction machine','Fontweight','Bold');
grid on;