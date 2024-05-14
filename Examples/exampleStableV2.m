clc
%% System parameters
a = 1;
b = 1;
z = 1;
h = 1;
p = 10000;
w_1 = 0;
w_2 = 10;
sigma_1 = 0;
sigma_2 = 2;
ps = 50;
%% Finding the collapse point 
[sigma_max, kp_max, ki_max] = SAOpt(a, b, z, h, w_1, w_2, sigma_1, sigma_2, p, ps)